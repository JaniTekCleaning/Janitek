class ClientsController < ApplicationController
  before_action :set_client, except:[:index,:new,:create]

  respond_to :html

  def index
    @name=params[:by_name]
    @clients = Client.filter(params.slice(:by_name)).order('name asc').paginate(:page=>params[:page], :per_page => 12)
    respond_with(@clients)
  end

  def show
    respond_with(@client)
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

  def new_contract
    @link=Link.new
    respond_with(@link)
  end

  def create_contract
    debugger
    #@link = Link.new(link_params.merge({:is_contract?=>true}))
    @link.save
    respond_with(@client,@link)
  end

  private
    def set_client
      id=params[:id]
      id||=params[:client_id]
      @client = Client.find(id)
    end

    def client_params
      params.require(:client).permit(:name, :number, :email, :hot_button_list)
    end

    def link_params
      params.require(:link).permit(:url)
    end
end
