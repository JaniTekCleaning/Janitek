class ApplicationController < ActionController::Base
  include Pundit
  before_filter :authenticate_user!, unless: :devise_controller?
  after_action :verify_authorized, unless: :devise_controller?
  after_action :log_action
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:password, :password_confirmation, :current_password) 
    }
  end

  rescue_from Member::CannotResetPasswordException, with: :render_cannot_reset_password

  def render_cannot_reset_password
    redirect_to new_user_session_path, alert:"You may not reset your password.  Please contact support instead."
  end
  
  protected

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      if params[:controller]=="root"
        redirect_to new_user_session_path
      else
        redirect_to new_user_session_path, :notice => 'Must be logged in to view this page'
      end
      
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def log_action
    return unless current_user
    log=ActionLog.create({
      :controller=>params[:controller],
      :action=>params[:action],
      :user=>current_user
      })
    # raise ActionLog::UnrecognizedRequest unless log.request_recognized?
  end
end