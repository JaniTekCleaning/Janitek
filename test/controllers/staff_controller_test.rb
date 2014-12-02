require 'test_helper'

class StaffControllerTest < ActionController::TestCase
  context 'authorized as member' do
    setup do
      @staff = Fabricate(:staff)
      @client=Fabricate(:client)
      sign_in Fabricate(:member, :client=>@client)
    end

    should "not get index" do
      assert_raises(Pundit::NotAuthorizedError){get :index}
    end

    should "not get new" do
      assert_raises(Pundit::NotAuthorizedError){get :new}
    end

    should "not create staff" do
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, staff: { :email=>@staff.email+'unique.test', :first_name=>'ron',
          :last_name=>'lugge', :password=>'password',:password_confirmation=>'password' }
      end
    end

    should "not show general staff" do
      assert_raises(Pundit::NotAuthorizedError){get :show, id: @staff}
    end

    should "show janitorial lead staff" do
      @client.update(:staff=>@staff)
      get :show, id: @staff
      assert_response :success
    end

    should "not get edit" do
      assert_raises(Pundit::NotAuthorizedError){get :edit, id: @staff}
    end

    should "not update staff" do
      assert_raises(Pundit::NotAuthorizedError){patch :update, id: @staff, staff: { :email=>'ronlugge@test.test' }}
    end
  end
  context 'authorized as staff' do
    setup do
      @staff = Fabricate(:staff)
      sign_in Fabricate(:staff)
    end

    should "get index" do
      get :index
      assert_response :success
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create staff" do
      assert_difference('Staff.count') do
        post :create, staff: { :email=>@staff.email+'unique.test', :first_name=>'ron',
          :last_name=>'lugge', :password=>'password',:password_confirmation=>'password' }
      end

      assert_redirected_to staff_path(assigns(:staff))
    end

    should "show staff" do
      get :show, id: @staff
      assert_response :success
    end

    should "get edit" do
      get :edit, id: @staff
      assert_response :success
    end

    should "update staff" do
      patch :update, id: @staff, staff: { :email=>'ronlugge@test.test' }
      assert_redirected_to staff_path(assigns(:staff))
    end
  end
    

  # should "destroy staff" do
  #   assert_difference('Staff.count', -1) do
  #     delete :destroy, id: @staff, client_id: @client.id
  #   end

  #   assert_redirected_to client_path(@client)
  # end
end
