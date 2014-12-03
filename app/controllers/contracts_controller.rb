class ContractsController < ApplicationController
  before_action :set_client
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  before_filter :add_breadcrumbs

  respond_to :html
  def new
    authorize Contract
    @contract = Contract.new
    respond_with(@contract)
  end

  def create
    authorize Contract
    @contract = Contract.new(contract_params.merge(:client_id=>@client.id))
    @contract.save
    respond_with(@client,@contract)
  end

  def show
    authorize @contract
    TrackingMailer.viewed_contract(current_user).deliver if current_user.type=="Member"
  end

  private
    def add_breadcrumbs
      add_breadcrumb "Home", :root_path
      add_breadcrumb "Clients", clients_path if current_user.type=="Staff"
      add_breadcrumb @client.name, client_path(@client) if current_user.type=="Staff"
      add_breadcrumb "Contract", client_contract_path(@client,@contract) if @contract
    end
    
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
