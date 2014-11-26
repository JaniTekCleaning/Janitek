require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  setup do
    @client = Fabricate(:client)
    @schedule = Fabricate(:schedule, :client=>@client)
  end

  test "should get new" do
    get :new, client_id: @client.id
    assert_response :success
  end

  test "should create schedule" do
    assert_difference('Schedule.count') do
      post :create, schedule: { :url=>"abc" }, client_id: @client.id
    end

    assert_redirected_to client_schedule_path(@client, assigns(:schedule))
  end

  test 'created schedule should have client id' do
    post :create, schedule: { :url=>"abc" }, client_id: @client.id
    assert Schedule.last.client==@client, 'schedule should have client id assigned'
  end

  test "should show schedule" do
    get :show, id: @schedule, client_id: @client.id
    assert_redirected_to client_path(@client)
  end
end
