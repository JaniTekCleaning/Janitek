require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  context 'authorized as current member' do
    setup do
      @client=Fabricate(:client)
      @member = Fabricate(:member, :client=>@client)
      sign_in @member
    end

    should "should get index" do
      assert_raises(Pundit::NotAuthorizedError){get :index, client_id: @client.id}
    end

    should "should get new" do
      assert_raises(Pundit::NotAuthorizedError){get :new, client_id: @client.id}
    end

    should "should not create member" do
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, member: { :email=>'ronlugge@test.test', :first_name=>'ron',
          :last_name=>'lugge', :password=>'password',:password_confirmation=>'password' },
          client_id: @client.id
      end
    end

    should "should show member" do
      get :show, id: @member, client_id: @client.id
      assert_response :success
    end

    should "should get edit" do
      get :edit, id: @member, client_id: @client.id
      assert_response :success
    end

    should "should update member" do
      patch :update, id: @member, member: { :email=>'ronlugge@test.test' }, client_id: @client.id
      assert_redirected_to client_member_path(@client, assigns(:member))
    end
    should 'not update password' do
      assert_raises(Member::CannotChangePasswordException) do
        patch :update, id:@member, member: { :email=>'ronlugge@test.test', :first_name=>'ron',
          :last_name=>'lugge', :password=>'password',:password_confirmation=>'password' },
          client_id: @client.id
      end
    end
  end
  context 'authorized as general member' do
    setup do
      @client=Fabricate(:client)
      @member = Fabricate(:member, :client=>@client)
      sign_in Fabricate(:member, :client=>@client)
    end
    should "should not show member" do
      assert_raises(Pundit::NotAuthorizedError){get :show, id: @member, client_id: @client.id}
    end

    should "should not get edit" do
      assert_raises(Pundit::NotAuthorizedError){get :edit, id: @member, client_id: @client.id}
    end

    should "should not update member" do
      assert_raises(Pundit::NotAuthorizedError) do
        patch :update, id: @member, member: { :email=>'ronlugge@test.test' }, client_id: @client.id
      end
    end
  end
  context 'authorized as staff' do
    setup do
      @client=Fabricate(:client)
      @member = Fabricate(:member, :client=>@client)
      sign_in Fabricate(:staff)
    end

    should "should get index" do
      get :index, client_id: @client.id
      assert_redirected_to client_path(@client)
    end

    should "should get new" do
      get :new, client_id: @client.id
      assert_response :success
    end

    should "should create member" do
      assert_difference('Member.count') do
        post :create, member: { :email=>'ronlugge@test.test', :first_name=>'ron',
          :last_name=>'lugge', :password=>'password',:password_confirmation=>'password' },
          client_id: @client.id
      end

      assert_redirected_to client_member_path(@client, assigns(:member))
    end

    should 'created member should have client id' do
      post :create, member: { :email=>'ronlugge@test.test', :first_name=>'ron',
          :last_name=>'lugge', :password=>'password',:password_confirmation=>'password' },
          client_id: @client.id
      assert Member.last.client==@client, 'schedule should have client id assigned'
    end

    should "should show member" do
      get :show, id: @member, client_id: @client.id
      assert_response :success
    end

    should "should get edit" do
      get :edit, id: @member, client_id: @client.id
      assert_response :success
    end

    should "should update member" do
      patch :update, id: @member, member: { :email=>'ronlugge@test.test' }, client_id: @client.id
      assert_redirected_to client_member_path(@client, assigns(:member))
    end
  end
    

  # should "should destroy member" do
  #   assert_difference('Member.count', -1) do
  #     delete :destroy, id: @member, client_id: @client.id
  #   end

  #   assert_redirected_to client_path(@client)
  # end
end
