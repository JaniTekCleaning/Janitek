class SchedulesController < ApplicationController
  before_action :set_client
  before_action :set_building
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  respond_to :html
  def new
    authorize Schedule
    @schedule = Schedule.new
    respond_with(@schedule)
  end

  def create
    authorize Schedule
    @schedule = Schedule.new(schedule_params.merge(:building_id=>@building.id))
    @schedule.save
    respond_with(@client,@building,@schedule)
  end

  def show
    authorize @schedule
    TrackingMailer.viewed_schedule(current_user).deliver_now if current_user.type=="Member"
    set_client unless @client
    @staff=@client.staff
  end

  def edit
    authorize @schedule
  end

  def update
    authorize @schedule
    if @schedule.update(update_schedule_params)
      redirect_to [@client, @building]
    else
      render :edit
    end
  end

  def destroy
    authorize @schedule
    @schedule.destroy
    redirect_to [@client, @building]
  end

  private

    def set_schedule
      set_client unless @client
      @schedule = Schedule.find(params[:id])
    end

    def set_client
      @client ||= Client.find(params[:client_id])
    end

    def set_building
      @building = Building.find(params[:building_id])
    end

    def schedule_params
      params.require(:schedule).permit(:url, :s3, :title)
    end

    def update_schedule_params
      params.require(:schedule).permit(:title)
    end
end
