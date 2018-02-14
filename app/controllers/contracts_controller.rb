class ContractsController < ApplicationController
  before_action :set_client
  before_action :set_building
  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  respond_to :html
  def new
    authorize Contract
    @contract = Contract.new
    respond_with(@contract)
  end

  def create
    authorize Contract
    @contract = Contract.new(contract_params.merge(:building_id=>@building.id))
    @contract.save
    respond_with(@client,@contract)
  end

  def show
    authorize @contract
    TrackingMailer.viewed_contract(current_user).deliver_now if current_user.type=="Member"
    @staff = @client.staff
  end

  def edit
    authorize @contract
  end

  def update
    authorize @contract
    if @contract.update(update_contract_params)
      redirect_to client_path(@client)
    else
      render :edit
    end
  end

  def destroy
    authorize @contract
    @contract.destroy
    redirect_to @client
  end

  private
    
    def set_contract
      @contract = Contract.find(params[:id])
    end

    def set_building
      @building ||= Building.find(params[:building_id])
    end

    def set_client
      @client ||= Client.find(params[:client_id])
    end

    def contract_params
      params.require(:contract).permit(:url, :s3, :title)
    end

    def update_contract_params
      params.require(:contract).permit(:title)
    end
end
