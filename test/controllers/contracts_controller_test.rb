require 'test_helper'

class ContractsControllerTest < ActionController::TestCase
  setup do
    @client = Fabricate(:client)
    @contract = Fabricate(:contract, :client=>@client)
  end

  test "should get new" do
    get :new, client_id: @client.id
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post :create, contract: { :url=>"abc" }, client_id: @client.id
    end

    assert_redirected_to client_contract_path(@client, assigns(:contract))
  end

  test 'created contract should have client id' do
    post :create, contract: { :url=>"abc" }, client_id: @client.id
    assert Contract.last.client==@client, 'contract should have client id assigned'
  end

  test "should show contract" do
    get :show, id: @contract, client_id: @client.id
    assert_redirected_to client_path(@client)
  end
end
