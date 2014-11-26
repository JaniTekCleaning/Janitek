class ContractsController < ApplicationController
  before_action :set_client
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  respond_to :html
  def new
    @contract = Contract.new
    respond_with(@contract)
  end

  def create
    @contract = Contract.new(contract_params.merge(:client_id=>@client.id))
    @contract.save
    respond_with(@client,@contract)
  end

  def show
    redirect_to @client
  end

  private
    def set_contract
      set_client unless @client
      @contract = @client.contracts.find(params[:id])
    end

    def set_client
      @client ||= Client.find(params[:client_id])
    end

    def contract_params
      params.require(:contract).permit(:url, :s3)
    end
end
