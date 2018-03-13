class ServiceRequestController < ApplicationController

  before_action :set_client, only:[:show, :submit]
  before_action :set_service_request
  before_action :authorize_controller
  before_action :redirect_staff, only:[:show,:submit]

  def show
    @staff=@client.staff
    #add_breadcrumb "Service Request Form", service_request_path
  end

  def submit
    if params[:form_version].to_i != @service_request.version_number
      flash[:notice] = "Service Request Form has been updated.  Please fill out the new form."
      redirect_to service_request_path
      return
    end
    ActiveRecord::Base.transaction do
      fields = ServiceRequest.last.fields
      data = params[:formField]
      service_request = fields.each_with_index.map do |item, index|
        {"title": item["title"], "type":item["type"],"value":data[index.to_s]}
      end
      # byebug
      current_building.update!(last_service_request: service_request)
      ContactMailer.service_request(params[:formField],current_user).deliver_now
    end
    redirect_to root_path
  end

  def edit
    # add_breadcrumb "Edit Service Request Form", service_request_edit_path
  end

  def update
    # add_breadcrumb "Edit Service Request Form", service_request_edit_path
    items=params[:service_item_title].reject{|key, value| value.nil? || value.empty?}
    items = items.map do |key, value|
      {
        "title"=>value,
        "type"=>params[:service_item_type][key]
        # "required"=>!(params[:service_item_required][key].nil?)
      }
    end
    @service_request.fields=items
    @service_request.version_number=0 if @service_request.version_number.nil?
    @service_request.version_number+=1
    flash[:notice]= 'Service Request Form updated.' if @service_request.save
    render 'edit'
  end
  
  def set_client
    @client ||= Client.find(current_user.client_id) unless current_user.is_a? Staff
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
