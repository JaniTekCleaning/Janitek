class ClientsController < ApplicationController
  before_action :set_client, except:[:index,:new,:create]
  before_filter :add_breadcrumbs

  respond_to :html

  def index
    authorize Client
    @name=params[:by_name]
    @clients = Client.filter(params.slice(:by_name)).order('name asc').paginate(:page=>params[:page], :per_page => 12).load
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
    add_breadcrumb "New", new_client_path
    respond_with(@client)
  end

  def edit
    authorize @client
    add_breadcrumb "Edit", edit_client_path(@client)
  end

  def create
    authorize Client
    @client = Client.new(client_params)
    @client.save
    add_breadcrumb "New", new_client_path
    respond_with(@client)
  end

  def update
    authorize @client
    @client.update(client_params)
    add_breadcrumb "Edit", edit_client_path(@client)
    respond_with(@client)
  end

  def destroy
    authorize @client
    @client.destroy
    respond_with(@client)
  end

  def edit_hotbutton
    authorize @client
    add_breadcrumb current_user.type=='Staff' ? "Edit" : "Hotbuttons", client_edit_hotbutton_path(@client)
  end

  def update_hotbutton
    authorize @client
    add_breadcrumb "Edit", client_edit_hotbutton_path(@client)
    items=params[:hotbutton_item].reject{|item| item.empty?}
    @client.hot_button_items=items
    if @client.valid?
      if current_user.type=='Staff'
        redirect_to client_path(@client), notice: "Hot Button List updated"
      else
        flash[:notice] = "Hot Button List updated"
        render 'edit_hotbutton'
        if @client.hot_button_items_changed?
          TrackingMailer.edited_hotbutton(current_user).deliver
        end
      end
      @client.save
    else
      render 'edit_hotbutton'
    end
  end

  private
    def add_breadcrumbs
      add_breadcrumb "Home", :root_path
      add_breadcrumb "Clients", clients_path if current_user.type=="Staff"
      add_breadcrumb @client.name, client_path(@client) if @client && current_user.type=="Staff"
    end

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
