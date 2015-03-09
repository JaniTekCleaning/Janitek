class StaffController < ApplicationController
  before_action :set_staff, except:[:index,:new,:create]
  before_filter :add_breadcrumbs

  respond_to :html

  def index
    authorize Staff
    @name=params[:by_name]
    @staff = Staff.filter(params.slice(:by_name)).order('first_name asc').paginate(:page=>params[:page], :per_page => 12).load
    respond_with(@staff)
  end

  def show
    authorize @staff
    respond_with(@staff)
  end

  def new
    authorize Staff
    @staff = Staff.new
    add_breadcrumb "New", new_staff_path
    respond_with(@staff)
  end

  def edit
    authorize @staff
    add_breadcrumb "Edit", edit_staff_path(@staff)
  end

  def create
    authorize Staff
    @staff = Staff.new(staff_registration_params)
    @staff.save
    add_breadcrumb "New", new_staff_path
    respond_with(@staff)
  end

  def update
    authorize @staff
    @staff.update(staff_update_params)
    @staff.update_with_password(staff_password_params) if staff_password_params.delete_if{|k,v|v.empty?}.any? && !(current_user.admin && current_user==@user)
    add_breadcrumb "Edit", edit_staff_path(@staff)
    respond_with @staff
  end

  def log
    authorize @staff
    @logs=@staff.action_logs.order('created_at desc').paginate(:page=>params[:page], :per_page => 100)
  end

  private
    def add_breadcrumbs
      add_breadcrumb "Home", :root_path
      add_breadcrumb "Staff", staff_index_path if current_user.type=="Staff"
      add_breadcrumb @staff.full_name, staff_path(@staff) if @staff
    end
    def set_staff
      @staff = Staff.find(params[:id])
    end
    def staff_registration_params
      params.require(:staff).permit(:description, :email,:first_name,:last_name,:password,:password_confirmation,:avatar,:office,:cell,:title)
    end
    def staff_update_params
      params.require(:staff).permit(*policy(@staff || Staff).permitted_attributes)
    end
    def staff_password_params
      params.require(:staff).permit(:password,:password_confirmation,:current_password)
    end
end
