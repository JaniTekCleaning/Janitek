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

    should "should create client" do
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, client: { name:@client.name, email: @client.email, hot_button_items: @client.hot_button_items, number: @client.number }
      end
    end

    should "should show client as member of that client" do
      get :show, id: @client
      assert_response :success
    end

    should 'not show client if not member of that client' do
      @user.client=Fabricate(:client)
      @user.save
      assert_raises(Pundit::NotAuthorizedError){get :show, id: @client}
    end

    should "should not get edit" do
      assert_raises(Pundit::NotAuthorizedError){get :edit, id: @client}
    end

    should "should not update client" do
      assert_raises(Pundit::NotAuthorizedError) do
        patch :update, id: @client, client: { email: @client.email, hot_button_items: @client.hot_button_items, number: @client.number }
      end
    end

    should "should destroy client" do
      assert_raises(Pundit::NotAuthorizedError) do
        delete :destroy, id: @client
      end
    end

    should 'update hot button items' do
      Client.expects(:find).returns(@client)
      @client.expects(:hot_button_items=)
      @client.expects(:save)
      put :update_hotbutton, client_id:@client, hotbutton_item:["1","2","3"]
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

    should 'update hot button items' do
      Client.expects(:find).returns(@client)
      @client.expects(:hot_button_items=)
      @client.expects(:save)
      put :update_hotbutton, client_id:@client, hotbutton_item:["1","2","3"]
    end
  end
end
