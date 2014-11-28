class RootController < ApplicationController
  def index
    authorize :root, :index?
    if !current_user
      redirect_to new_user_session_path
      return
    end
  end
end
