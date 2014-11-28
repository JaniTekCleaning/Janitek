class SchedulesController < ApplicationController
  before_action :set_client
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  respond_to :html
  def new
    authorize Schedule
    @schedule = Schedule.new
    respond_with(@schedule)
  end

  def create
    authorize Schedule
    @schedule = Schedule.new(schedule_params.merge(:client_id=>@client.id))
    @schedule.save
    respond_with(@client,@schedule)
  end

  def show
    authorize @schedule
  end

  private
    def set_schedule
      set_client unless @client
      @schedule = @client.schedules.find(params[:id])
    end

    def set_client
      @client ||= Client.find(params[:client_id])
    end

    def schedule_params
      params.require(:schedule).permit(:url, :s3)
    end
end
