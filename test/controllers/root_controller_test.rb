require 'test_helper'

class RootControllerTest < ActionController::TestCase
  test "should get index when logged in" do
    sign_in Fabricate(:member,:client=>Fabricate(:client))
    get :index
    assert_response :success
  end

end
