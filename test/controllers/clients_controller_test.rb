require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  context 'authorized as member' do
    setup do
      @client=Fabricate(:client)
      @user=Fabricate(:member,:client=>@client)
      sign_in @user
    end

    should "should not get index" do
      assert_raises(Pundit::NotAuthorizedError){get :index}
    end

    should "should get new" do
      assert_raises(Pundit::NotAuthorizedError){get :new}
    end

    should "should not create client" do
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, client: { name:@client.name, email: @client.email, hot_button_items: @client.hot_button_items, number: @client.number }
      end
    end

    should "should not show client as member of that client" do
      assert_raises(Pundit::NotAuthorizedError){get :show, id: Fabricate(:client)}
    end

    should 'not show client if not member of that client' do
      assert_raises(Pundit::NotAuthorizedError){get :show, id: Fabricate(:client)}
    end

    should "should get edit if member of client" do
      get :edit, id: @client
      assert_response :success
    end

    should "should not get edit unless member of client" do
      assert_raises(Pundit::NotAuthorizedError){get :edit, id: Fabricate(:client)}
    end

    should "should update if member of client" do
      patch :update, id: @client, client: { email: @client.email, hot_button_items: @client.hot_button_items, number: @client.number }
      assert_redirected_to client_path(assigns(:client))
    end

    should "should not update unless member of client" do
      assert_raises(Pundit::NotAuthorizedError) do
        patch :update, id: Fabricate(:client), client: { email: @client.email, hot_button_items: @client.hot_button_items, number: @client.number }
      end
    end

    should "should not destroy client" do
      assert_raises(Pundit::NotAuthorizedError) do
        delete :destroy, id:@client.id
      end
    end
  end
  context 'authorized as staff' do
    setup do
      @client = Fabricate(:client)
      sign_in Fabricate(:staff)
    end

    should "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:clients)
    end

    should "should get new" do
      get :new
      assert_response :success
    end

    should "should create client" do
      assert_difference('Client.count') do
        post :create, client: { name:@client.name, email: @client.email, hot_button_items: @client.hot_button_items, number: @client.number }
      end

      assert_redirected_to client_path(assigns(:client))
    end

    should "should show client" do
      get :show, id: @client
      assert_response :success
    end

    should "should get edit" do
      get :edit, id: @client
      assert_response :success
    end

    should "should update client" do
      patch :update, id: @client, client: { email: @client.email, hot_button_items: @client.hot_button_items, number: @client.number }
      assert_redirected_to client_path(assigns(:client))
    end

    should "should destroy client" do
      assert_difference('Client.count', -1) do
        delete :destroy, id: @client
      end

      assert_redirected_to clients_path
    end
  end
end
