require 'test_helper'

class RootControllerTest < ActionController::TestCase
  test "should get index when logged in" do
    sign_in Fabricate(:member,:client=>Fabricate(:client))
    get :index
    assert_response :success
  end
  test 'should generate an action log when logged in' do
    assert_difference('ActionLog.count') do
      sign_in Fabricate(:member,:client=>Fabricate(:client))
      get :index
    end
  end
end
