class ServiceRequestController < ApplicationController

  before_action :set_service_request
  before_action :authorize_controller
  before_action :redirect_staff, only:[:show,:submit]

  def show
    add_breadcrumb "Service Request Form", service_request_path
  end

  def submit
    ContactMailer.service_request(@service_request, params[:service_items],current_user).deliver
    redirect_to root_path
  end

  def edit
    add_breadcrumb "Edit Service Request Form", service_request_edit_path
  end

  def update
    add_breadcrumb "Edit Service Request Form", service_request_edit_path
    items=params[:variable_item].reject{|item| item.empty?}
    @service_request.fields=items
    flash[:notice]='Service Request Form updated.' if @service_request.save
    render 'edit'
  end

  def set_service_request
    @service_request=ServiceRequest.first
    @service_request||=ServiceRequest.new
    @service_request.fields||=[]
  end

  def authorize_controller
    authorize @service_request
  end

  def redirect_staff
    redirect_to service_request_edit_path if current_user.is_a? Staff
  end
end
