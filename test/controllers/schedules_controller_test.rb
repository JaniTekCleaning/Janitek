require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  context 'authorized as client member' do
    setup do
      @client = Fabricate(:client)
      @building = Fabricate(:building, client: @client)
      @schedule = Fabricate(:schedule, :building=>@building)
      @member=Fabricate(:member, :client=>@client)
      sign_in @member
    end

    should "should not get new" do
      assert_raises(Pundit::NotAuthorizedError){get :new, client_id: @client.id, building_id: @building.id}
    end

    should "should not create schedule" do
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, schedule: { :url=>"abc" }, client_id: @client.id, building_id: @building.id
      end
    end

    should "should not edit schedule" do
      assert_raises(Pundit::NotAuthorizedError) do
        get :edit, id:@schedule.id, client_id: @client.id, building_id: @building.id
      end
    end

    should "should not update schedule" do
      assert_raises(Pundit::NotAuthorizedError) do
        put :update, id:@schedule.id, schedule: { :title=>"abc" }, client_id: @client.id, building_id: @building.id
      end
    end

    should "should not destroy schedule" do
      assert_raises(Pundit::NotAuthorizedError) do
        delete :destroy, id:@schedule.id, client_id: @client.id, building_id: @building.id
      end
    end

    should "should show schedule" do
      get :show, id: @schedule, client_id: @client.id, building_id: @building.id
      assert_response :success
    end
    should 'email when showing schedule' do
      message=mock('mailer')
      TrackingMailer.expects(:viewed_schedule).with(@member).returns(message)
      message.expects(:deliver_now)
      get :show, id: @schedule, client_id: @client.id, building_id: @building.id
    end
  end
  context 'authorized as general member' do
    setup do
      @client = Fabricate(:client)
      @building = Fabricate(:building, client: @client)
      @schedule = Fabricate(:schedule, :building=>@building)
      sign_in Fabricate(:member, :client=>Fabricate(:client))
    end

    should "should not show schedule" do
      assert_raises(Pundit::NotAuthorizedError){get :show, id: @schedule, client_id: @client.id, building_id: @building.id}
    end

    should "should not edit schedule" do
      assert_raises(Pundit::NotAuthorizedError) do
        get :edit, id:@schedule.id, client_id: @client.id, building_id: @building.id
      end
    end

    should "should not update schedule" do
      assert_raises(Pundit::NotAuthorizedError) do
        put :update, id:@schedule.id, schedule: { :title=>"abc" }, client_id: @client.id, building_id: @building.id
      end
    end

    should "should not destroy schedule" do
      assert_raises(Pundit::NotAuthorizedError) do
        delete :destroy, id:@schedule.id, client_id: @client.id, building_id: @building.id
      end
    end
  end
  context 'authorized as staff' do
    setup do
      @client = Fabricate(:client)
      @building = Fabricate(:building, client: @client)
      @schedule = Fabricate(:schedule, :building=>@building)
      sign_in Fabricate(:staff)
    end

    should "should get new" do
      get :new, client_id: @client.id, building_id: @building.id
      assert_response :success
    end

    should "should create schedule" do
      assert_difference('Schedule.count') do
        post :create, schedule: { :url=>"abc", title: "Foo" }, client_id: @client.id, building_id: @building.id
      end

      assert_redirected_to [@client, @building, assigns(:schedule)]
    end

    should 'created schedule should have client id' do
      post :create, schedule: { :url=>"abc" }, client_id: @client.id, building_id: @building.id
      assert Schedule.last.client==@client, 'schedule should have client id assigned'
    end

    should "should show schedule" do
      get :show, id: @schedule, client_id: @client.id, building_id: @building.id
      assert_response :success
    end

    should 'get edit' do
      get :edit, id: @schedule, client_id: @client.id, building_id: @building.id
      assert_response :success
    end

    should 'update schedule' do
      put :update, id: @schedule.id, client_id: @client.id, building_id: @building.id, schedule: { title: "New" }
      assert_redirected_to [@client, @building]
    end

    context 'destroy schedule' do
      should 'redirect to client' do
        delete :destroy, id: @schedule.id, client_id: @client.id, building_id: @building.id
        assert_redirected_to client_path(@client)
      end
      should 'destroy schedule' do
        assert_difference -> { Schedule.count }, -1 do
          delete :destroy, id: @schedule.id, client_id: @client.id, building_id: @building.id
        end
      end
    end

    should 'not email when showing schedule' do
      TrackingMailer.expects(:viewed_schedule).never
      get :show, id: @schedule, client_id: @client.id, building_id: @building.id
    end
  end
  
end
