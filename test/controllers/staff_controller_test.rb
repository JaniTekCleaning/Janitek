require 'test_helper'

class StaffControllerTest < ActionController::TestCase
  setup do
    @staff = Fabricate(:staff)
  end

  test "should get index" do
    get :index
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff" do
    assert_difference('Staff.count') do
      post :create, staff: { :email=>@staff.email+'unique.test', :first_name=>'ron',
        :last_name=>'lugge', :password=>'password',:password_confirmation=>'password' }
    end

    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should show staff" do
    get :show, id: @staff
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @staff
    assert_response :success
  end

  test "should update staff" do
    patch :update, id: @staff, staff: { :email=>'ronlugge@test.test' }
    assert_redirected_to staff_path(assigns(:staff))
  end

  # test "should destroy staff" do
  #   assert_difference('Staff.count', -1) do
  #     delete :destroy, id: @staff, client_id: @client.id
  #   end

  #   assert_redirected_to client_path(@client)
  # end
end
