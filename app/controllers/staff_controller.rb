class StaffController < ApplicationController
  before_action :set_staff, except:[:index,:new,:create]

  respond_to :html

  def index
    @name=params[:by_name]
    @staff = Staff.filter(params.slice(:by_name)).order('first_name asc').paginate(:page=>params[:page], :per_page => 12)
    respond_with(@staff)
  end

  def show
    respond_with(@staff)
  end

  def new
    @staff = Staff.new
    respond_with(@staff)
  end

  def edit
  end

  def create
    @staff = Staff.new(staff_registration_params)
    @staff.save
    respond_with(@staff)
  end

  def update
    @staff.update(staff_update_params)
    @staff.update_with_password(staff_password_params) if staff_password_params.delete_if{|k,v|v.empty?}.any?
    respond_with @staff
  end

  # def destroy
  #   @staff.destroy
  #   respond_with(@staff)
  # end

  private
    def set_staff
      @staff = Staff.find(params[:id])
    end
    def staff_registration_params
      params.require(:staff).permit(:description, :email,:first_name,:last_name,:password,:password_confirmation,:avatar)
    end
    def staff_update_params
      params.require(:staff).permit(:description, :email,:first_name,:last_name,:avatar)
    end
    def staff_password_params
      params.require(:staff).permit(:password,:password_confirmation,:current_password)
    end
end
