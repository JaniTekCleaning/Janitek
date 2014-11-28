require 'test_helper'

class ContractsControllerTest < ActionController::TestCase
  context 'authorized as member of client' do
    setup do
      @client = Fabricate(:client)
      @contract = Fabricate(:contract, :client=>@client)
      sign_in Fabricate(:member, :client=>@client)
    end

    should "should get new" do
      assert_raises(Pundit::NotAuthorizedError){get :new, client_id: @client.id}
    end

    should "should create contract" do
      assert_raises(Pundit::NotAuthorizedError) do
        post :create, contract: { :url=>"abc" }, client_id: @client.id
      end
    end

    should "should show contract" do
      get :show, id: @contract, client_id: @client.id
      assert_response :success
    end
  end
  context 'authorized as general member' do
    setup do
      @client = Fabricate(:client)
      @contract = Fabricate(:contract, :client=>@client)
      sign_in Fabricate(:member, :client=>Fabricate(:client))
    end

    should "should show contract" do
      assert_raises(Pundit::NotAuthorizedError) {get :show, id: @contract, client_id: @client.id}
    end
  end
  context 'authorized as staff' do
    setup do
      @client = Fabricate(:client)
      @contract = Fabricate(:contract, :client=>@client)
      sign_in Fabricate(:staff)
    end

    should "should get new" do
      get :new, client_id: @client.id
      assert_response :success
    end

    should "should create contract" do
      assert_difference('Contract.count') do
        post :create, contract: { :url=>"abc" }, client_id: @client.id
      end

      assert_redirected_to client_contract_path(@client, assigns(:contract))
    end

    should 'created contract should have client id' do
      post :create, contract: { :url=>"abc" }, client_id: @client.id
      assert Contract.last.client==@client, 'contract should have client id assigned'
    end

    should "should show contract" do
      get :show, id: @contract, client_id: @client.id
      assert_response :success
    end
  end
end
