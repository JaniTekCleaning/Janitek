class ClientsController < ApplicationController
  before_action :set_client, except:[:index,:new,:create]

  respond_to :html

  def index
    authorize Client
    @name=params[:by_name]
    @rep=params[:by_rep]
    @clients = Client.filter(params.slice(:by_name, :by_rep)).order('name asc').paginate(:page=>params[:page], :per_page => 12).load
    respond_with(@clients)
  end

  def show
    authorize @client
    @buildings = @client.buildings
    @staff=@client.staff
    respond_with(@client)
  end

  def new
    authorize Client
    @client = Client.new
    respond_with(@client)
  end

  def edit
    authorize @client
  end

  def create
    authorize Client
    @client = Client.new(client_params)
    @client.save
    respond_with(@client)
  end

  def update
    authorize @client
    @client.update(client_params)
    flash[:notice] = "Client updated"
    respond_with(@client)
  end

  def destroy
    authorize @client
    @client.destroy
    respond_with(@client)
  end

  private

    def set_client
      id=params[:id]
      id||=params[:client_id]
      @client = Client.find(id)
    end

    def client_params
      if current_user.is_a? Staff
        params.require(:client).permit(:staff_id, :name, :number, :email, :hot_button_list, :logo, :directnumber, :street1, :street2, :city, :state, :zip, :notes, :contacttitle, :contact)
      else
        params.require(:client).permit(:name, :number, :email, :hot_button_list, :logo, :directnumber, :street1, :street2, :city, :state, :zip, :notes, :contacttitle, :contact)
      end
    end

    def link_params
      params.require(:link).permit(:url)
    end
end
