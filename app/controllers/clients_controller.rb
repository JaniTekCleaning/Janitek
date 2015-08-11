class ClientsController < ApplicationController
  before_action :set_client, except:[:index,:new,:create]
  # before_filter :add_breadcrumbs

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
    @staff=@client.staff
    respond_with(@client,@contracts,@schedules)
  end

  def new
    authorize Client
    @client = Client.new
    # add_breadcrumb "New", new_client_path
    respond_with(@client)
  end

  def edit
    authorize @client
    # add_breadcrumb "Edit", edit_client_path(@client)
  end

  def create
    authorize Client
    @client = Client.new(client_params)
    @client.save
    # add_breadcrumb "New", new_client_path
    respond_with(@client)
  end

  def update
    authorize @client
    @client.update(client_params)
    # add_breadcrumb "Edit", edit_client_path(@client)
    flash[:notice] = "Client updated"
    respond_with(@client)
  end

  def destroy
    authorize @client
    @client.destroy
    respond_with(@client)
  end

  def edit_hotbutton
    authorize @client
    @staff = @client.staff
    @schedule=@client.schedules.order(created_at: :desc).first
    # add_breadcrumb current_user.type=='Staff' ? "Edit" : "Hotbuttons", client_edit_hotbutton_path(@client)
  end

  def update_hotbutton
    authorize @client
    add_breadcrumb "Edit", client_edit_hotbutton_path(@client)
    items=params[:variable_item].reject{|item| item.empty?}
    @client.hot_button_items=items
    if @client.valid?
      # redirect_to client_path(@client), notice: "Hot Button List updated"
      changed=@client.hot_button_items_changed?
      @client.save!
      if (!current_user.is_a? Staff) && changed
        TrackingMailer.edited_hotbutton(current_user).deliver_now
      end
    else
      # render 'edit_hotbutton'
    end
  end

  private
    def add_breadcrumbs
      # add_breadcrumb "Home", :root_path
      # add_breadcrumb "Clients", clients_path if current_user.type=="Staff"
      # add_breadcrumb @client.name, client_path(@client) if @client && current_user.type=="Staff"
    end

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
