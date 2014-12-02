require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  context 'authorized as client member' do
    setup do
      @client = Fabricate(:client)
      @schedule = Fabricate(:schedule, :client=>@client)
      @member=Fabricate(:member, :client=>@client)
      sign_in @member
    end

    should "should not get new" do
      assert_raises(Pundit::NotAuthorizedError){get :new, client_id: @client.id}
    end

    should "should not create schedule" do
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, schedule: { :url=>"abc" }, client_id: @client.id
      end
    end

    should "should show schedule" do
      get :show, id: @schedule, client_id: @client.id
      assert_response :success
    end
    should 'email when showing schedule' do
      message=mock('mailer')
      TrackingMailer.expects(:viewed_schedule).with(@member).returns(message)
      message.expects(:deliver)
      get :show, id: @schedule, client_id: @client.id
    end
  end
  context 'authorized as general member' do
    setup do
      @client = Fabricate(:client)
      @schedule = Fabricate(:schedule, :client=>@client)
      sign_in Fabricate(:member, :client=>Fabricate(:client))
    end

    should "should not show schedule" do
      assert_raises(Pundit::NotAuthorizedError){get :show, id: @schedule, client_id: @client.id}
    end
  end
  context 'authorized as staff' do
    setup do
      @client = Fabricate(:client)
      @schedule = Fabricate(:schedule, :client=>@client)
      sign_in Fabricate(:staff)
    end

    should "should get new" do
      get :new, client_id: @client.id
      assert_response :success
    end

    should "should create schedule" do
      assert_difference('Schedule.count') do
        post :create, schedule: { :url=>"abc" }, client_id: @client.id
      end

      assert_redirected_to client_schedule_path(@client, assigns(:schedule))
    end

    should 'created schedule should have client id' do
      post :create, schedule: { :url=>"abc" }, client_id: @client.id
      assert Schedule.last.client==@client, 'schedule should have client id assigned'
    end

    should "should show schedule" do
      get :show, id: @schedule, client_id: @client.id
      assert_response :success
    end

    should 'not email when showing schedule' do
      TrackingMailer.expects(:viewed_schedule).never
      get :show, id: @schedule, client_id: @client.id
    end
  end
  
end
