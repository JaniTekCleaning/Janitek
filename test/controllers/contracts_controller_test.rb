require 'test_helper'

class ContractsControllerTest < ActionController::TestCase
  setup do
    @client = Fabricate(:client)
    @building = Fabricate(:building, client: @client)
  end
  context 'authorized as member of building' do
    setup do
      @contract = Fabricate(:contract, :building=>@building)
      @member=Fabricate(:member, :client=>@client, buildings: [@building])
      sign_in @member
    end

    should "should not get new" do
      assert_raises(Pundit::NotAuthorizedError){get :new, client_id: @client.id, building_id: @building.id}
    end

    should "should not create contract" do
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, contract: { :url=>"abc" }, client_id: @client.id, building_id: @building.id
      end
    end

    should "should not edit contract" do
      assert_raises(Pundit::NotAuthorizedError) do
        get :edit, id: @contract.id, client_id: @client.id, building_id: @building.id
      end
    end

    should "should not update contract" do
      assert_raises(Pundit::NotAuthorizedError) do
        put :update, id: @contract.id, contract: { :title=>"abc" }, client_id: @client.id, building_id: @building.id
      end
    end

    should "should show contract" do
      get :show, id: @contract, client_id: @client.id, building_id: @building.id
      assert_response :success
    end
    should 'email when showing contact' do
      message=mock('mailer')
      TrackingMailer.expects(:viewed_contract).with(@member).returns(message)
      message.expects(:deliver_now)
      get :show, id: @contract, client_id: @client.id, building_id: @building.id
    end

    should "should not destroy contract" do
      assert_raises(Pundit::NotAuthorizedError) do
        delete :destroy, id:@contract.id, client_id: @client.id, building_id: @building.id
      end
    end
  end
  context 'authorized as general member' do
    setup do
      @contract = Fabricate(:contract, :building=>@building)
      sign_in Fabricate(:member, :client=>Fabricate(:client))
    end

    should "should show contract" do
      assert_raises(Pundit::NotAuthorizedError) {get :show, id: @contract, client_id: @client.id, building_id: @building.id}
    end

    should "should not edit contract" do
      assert_raises(Pundit::NotAuthorizedError) do
        get :edit, id: @contract.id, client_id: @client.id, building_id: @building.id
      end
    end

    should "should not update contract" do
      assert_raises(Pundit::NotAuthorizedError) do
        put :update, id: @contract.id, contract: { :title=>"abc" }, client_id: @client.id, building_id: @building.id
      end
    end

    should "should not destroy contract" do
      assert_raises(Pundit::NotAuthorizedError) do
        delete :destroy, id:@contract.id, client_id: @client.id, building_id: @building.id
      end
    end
  end
  context 'authorized as staff' do
    setup do
      @contract = Fabricate(:contract, :building=>@building)
      sign_in Fabricate(:staff)
    end

    should "should get new" do
      get :new, client_id: @client.id, building_id: @building.id
      assert_response :success
    end

    should "should create contract" do
      assert_difference('Contract.count') do
        post :create, contract: { :url=>"abc", title: "Foo"  }, client_id: @client.id, building_id: @building.id
      end

      assert_redirected_to [@client, @building, assigns(:contract)]
    end

    should 'created contract should have client id' do
      post :create, contract: { :url=>"abc"}, client_id: @client.id, building_id: @building.id
      assert Contract.last.client==@client, 'contract should have building id assigned'
    end

    should "should show contract" do
      get :show, id: @contract, client_id: @client.id, building_id: @building.id
      assert_response :success
    end

    should 'get edit' do
      get :edit, id: @contract, client_id: @client.id, building_id: @building.id
      assert_response :success
    end

    should 'update contract' do
      put :update, id: @contract.id, client_id: @client.id, building_id: @building.id, contract: { title: "New" }
      assert_redirected_to [@client, @building]
    end

    context 'destroy contract' do
      should 'redirect to client' do
        delete :destroy, id: @contract.id, client_id: @client.id, building_id: @building.id
        assert_redirected_to [@client, @building]
      end
      should 'destroy contract' do
        assert_difference -> { Contract.count }, -1 do
          delete :destroy, id: @contract.id, client_id: @client.id, building_id: @building.id
        end
      end
    end

    should 'not email when showing schedule' do
      TrackingMailer.expects(:viewed_schedule).never
      get :show, id: @contract, client_id: @client.id, building_id: @building.id
    end
  end
end
