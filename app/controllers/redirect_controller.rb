class RedirectController < ApplicationController
  def home
    if !current_user
      path = new_user_session_path
    elsif current_user.force_password_reset
      path = edit_user_password_path
    else
      path = edit_user_password_path
    end
    redirect_to path
  end
end
