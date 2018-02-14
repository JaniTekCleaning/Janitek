class BuildingsController < ApplicationController
  before_action :set_client
  before_action :set_building, except:[:index,:new,:create]

  respond_to :html

  def show
    authorize @building
    @contracts=@building.contracts.limit(10).order(created_at: :desc)
    @schedules=@building.schedules.limit(10).order(created_at: :desc)
    @staff=@building.staff
    respond_with(@building,@contracts,@schedules)
  end

  def new
    @building = Building.new
    authorize @building
    respond_with(@building)
  end

  def edit
    authorize @building
  end

  def create
    @building = Building.new(building_params.merge(client_id:@client.id))
    authorize @building
    if @building.save
      redirect_to [@client, @building]
    else
      render :new
    end
  end

  def update
    authorize @building
    if @building.update(building_params)
      flash[:notice] = "Building updated"
      redirect_to [@client, @building]
    else
      render :edit
    end
  end

  def destroy
    authorize @building
    if @building.destroy
      redirect_to @client
    else
      render :show
    end
  end

  def edit_hotbutton
    authorize @building
    @staff = @building.staff
    @schedule=@building.schedules.order(created_at: :desc).first
    # add_breadcrumb current_user.type=='Staff' ? "Edit" : "Hotbuttons", building_edit_hotbutton_path(@building)
  end

  def update_hotbutton
    authorize @building
    add_breadcrumb "Edit", [:edit_hotbutton,@client,@building]
    items=params[:variable_item]
    items = items.reject{|item| item.empty?} if items
    @building.hot_button_items=items
    if @building.valid?
      # redirect_to building_path(@building), notice: "Hot Button List updated"
      changed=@building.hot_button_items_changed?
      @building.save!
      if (!current_user.is_a? Staff) && changed
        TrackingMailer.edited_hotbutton(current_user).deliver_now
      end
    else
      # render 'edit_hotbutton'
    end
  end

  private

    def set_client
      @client = Client.find(params[:client_id])
    end

    def set_building
      @building = Building.find(params[:id])
    end

    def building_params
      keys = [:name, :number, :email, :hot_button_list, :logo, :directnumber,
              :street1, :street2, :city, :state, :zip, :notes, :contacttitle,
              :contact]
      keys << :staff_id if current_user.is_a? Staff
      params.require(:building).permit(keys)
    end

    def link_params
      params.require(:link).permit(:url)
    end
end
