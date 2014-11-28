class ClientsController < ApplicationController
  before_action :set_client, except:[:index,:new,:create]

  respond_to :html

  def index
    authorize Client
    @name=params[:by_name]
    @clients = Client.filter(params.slice(:by_name)).order('name asc').paginate(:page=>params[:page], :per_page => 12)
    respond_with(@clients)
  end

  def show
    authorize @client
    @contracts=@client.contracts.limit(10).order(created_at: :desc)
    @schedules=@client.schedules.limit(10).order(created_at: :desc)
    respond_with(@client,@contracts,@schedules)
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
    respond_with(@client)
  end

  def destroy
    authorize @client
    @client.destroy
    respond_with(@client)
  end

  def edit_hotbutton
    authorize @client
  end

  def update_hotbutton
    authorize @client
    items=params[:hotbutton_item].reject{|item| item.empty?}
    @client.hot_button_items=items
    @client.save
    respond_with(@client)
  end

  private
    def set_client
      id=params[:id]
      id||=params[:client_id]
      @client = Client.find(id)
    end

    def client_params
      params.require(:client).permit(:staff_id, :name, :number, :email, :hot_button_list, :logo)
    end

    def link_params
      params.require(:link).permit(:url)
    end
end
