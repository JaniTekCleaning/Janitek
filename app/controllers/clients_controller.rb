class ClientsController < ApplicationController
  before_action :set_client, except:[:index,:new,:create]

  respond_to :html

  def index
    @name=params[:by_name]
    @clients = Client.filter(params.slice(:by_name)).order('name asc').paginate(:page=>params[:page], :per_page => 12)
    respond_with(@clients)
  end

  def show
    @contracts=@client.contracts.limit(10).order(created_at: :desc)
    @schedules=@client.schedules.limit(10).order(created_at: :desc)
    respond_with(@client,@contracts,@schedules)
  end

  def new
    @client = Client.new
    respond_with(@client)
  end

  def edit
  end

  def create
    @client = Client.new(client_params)
    @client.save
    respond_with(@client)
  end

  def update
    @client.update(client_params)
    respond_with(@client)
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  def edit_hotbutton
  end

  def update_hotbutton
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
      params.require(:client).permit(:name, :number, :email, :hot_button_list, :logo)
    end

    def link_params
      params.require(:link).permit(:url)
    end
end
