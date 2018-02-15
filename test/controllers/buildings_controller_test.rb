require 'test_helper'

class BuildingsControllerTest < ActionController::TestCase
  should 'get edit_hotbutton when no schedule set' do
    @client=Fabricate(:client)
    @user=Fabricate(:member,:client=>@client)
    @building=Fabricate(:building, client: @client, members: [@user])
    
    sign_in Fabricate(:staff)

    get :edit_hotbutton, client_id: @client.id, id: @building.id
    assert_response :success
  end
  context 'authorized as member' do
    setup do
      @client=Fabricate(:client)
      @user=Fabricate(:member,:client=>@client)
      @building=Fabricate(:building, client: @client, members: [@user])
      sign_in @user
    end

    should 'change current building' do
      @controller.current_building = Fabricate(:building, client:@client)
      put :select, client_id: @client.id, building: {id: @building.id}
      assert @controller.current_building.id == @building.id
      assert_redirected_to root_path
    end

    should "should get new" do
      assert_raises(Pundit::NotAuthorizedError){get :new, client_id: @client.id}
    end

    should "should not create building" do
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, client_id: @client.id, building: { name:@building.name, email: @building.email, hot_button_items: @building.hot_button_items, number: @building.number }
      end
    end

    should "should not show building as member of that building" do
      assert_raises(Pundit::NotAuthorizedError) do
        get :show, client_id: @client.id, id: Fabricate(:building, client: @client)
      end
    end

    should 'not show building if not member of that building' do
      assert_raises(Pundit::NotAuthorizedError) do
        get :show, client_id: @client.id, id: Fabricate(:building, client: @client)
      end
    end

    should "should get edit if member of building" do
      get :edit, client_id: @client.id, id: @building
      assert_response :success
    end

    should "should not get edit unless member of building" do
      assert_raises(Pundit::NotAuthorizedError) do
        get :edit, client_id: @client.id, id: Fabricate(:building, client: Fabricate(:client))
      end
    end

    should "should update if member of building" do
      patch :update, client_id: @client.id, id: @building, building: { email: @building.email, hot_button_items: @building.hot_button_items, number: @building.number }
      assert_redirected_to [@client, @building]
    end

    should "should not update unless member of building" do
      assert_raises(Pundit::NotAuthorizedError) do
        patch :update, client_id: @client.id, id: Fabricate(:building, client: Fabricate(:client)).id, building: { email: @building.email, hot_button_items: @building.hot_button_items, number: @building.number }
      end
    end

    should 'email when editing hot button items' do
      Building.expects(:find).returns(@building)
      message=mock('mailer')
      TrackingMailer.expects(:edited_hotbutton).with(@user).returns(message)
      message.expects(:deliver_now)

      put :update_hotbutton, client_id: @client.id, id:@building, variable_item:["1","2","3"]
    end

    should 'update hot button items' do
      Building.expects(:find).returns(@building)
      @building.expects(:hot_button_items=)
      @building.expects(:save!)
      put :update_hotbutton, client_id: @client.id, id:@building, variable_item:["1","2","3"]
    end

    should "should not destroy building" do
      assert_raises(Pundit::NotAuthorizedError) do
        delete :destroy, client_id: @client.id, id:@building.id
      end
    end
  end
  context 'authorized as staff' do
    setup do
      @client=Fabricate(:client)
      @building = Fabricate(:building, client: @client)
      sign_in Fabricate(:staff)
    end

    should "should get new" do
      get :new, client_id: @client.id
      assert_response :success
    end

    should "should create building" do
      assert_difference('Building.count') do
        post :create, client_id: @client.id, building: {
          name:@building.name, email: @building.email,
          hot_button_items: @building.hot_button_items, number: @building.number
        }
      end

      assert_redirected_to [@client,assigns(:building)]
    end

    should "should show building" do
      get :show, client_id: @client.id, id: @building
      assert_response :success
    end

    should "should get edit" do
      get :edit, client_id: @client.id, id: @building
      assert_response :success
    end

    should "should update building" do
      patch :update, client_id: @client.id, id: @building, building: { email: @building.email, hot_button_items: @building.hot_button_items, number: @building.number }
      assert_redirected_to [@client, assigns(:building)]
    end

    should "should destroy building" do
      assert_difference('Building.count', -1) do
        delete :destroy, client_id: @client.id, id: @building
      end

      assert_redirected_to @client
    end

    context "#update_hotbutton" do
      should 'update hot button items' do
        Building.expects(:find).returns(@building)
        @building.expects(:hot_button_items=)
        @building.expects(:save!)
        put :update_hotbutton, client_id: @client.id, id:@building, variable_item:["1","2","3"]
      end

      should 'function with nil params' do
        put :update_hotbutton, client_id: @client.id, id:@building
        assert_response :success
      end
    end

    should 'not email when updating hot button items' do
      TrackingMailer.expects(:edited_hotbutton).never
      put :update_hotbutton, client_id: @client.id, id:@building, variable_item:["1","2","3"]
    end
  end
end
