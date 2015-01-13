class RootController < ApplicationController
  def index
    authorize :root, :index?
    if !current_user
      redirect_to new_user_session_path
      return
    end
    if current_user.class==Member && current_user.client
      @client=current_user.client
      @staff=current_user.client.staff
    end
  end
end
