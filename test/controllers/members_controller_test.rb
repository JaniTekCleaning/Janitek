require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @client=Fabricate(:client)
    @member = Fabricate(:member, :client=>@client)
  end

  test "should get index" do
    get :index, client_id: @client.id
    assert_redirected_to client_path(@client)
  end

  test "should get new" do
    get :new, client_id: @client.id
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post :create, member: { :email=>'ronlugge@test.test', :first_name=>'ron',
        :last_name=>'lugge', :password=>'password',:password_confirmation=>'password' },
        client_id: @client.id
    end

    assert_redirected_to client_member_path(@client, assigns(:member))
  end

  test "should show member" do
    get :show, id: @member, client_id: @client.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member, client_id: @client.id
    assert_response :success
  end

  test "should update member" do
    patch :update, id: @member, member: { :email=>'ronlugge@test.test' }, client_id: @client.id
    assert_redirected_to client_member_path(@client, assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, id: @member, client_id: @client.id
    end

    assert_redirected_to client_path(@client)
  end
end
