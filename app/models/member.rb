class Member < User
  class CannotResetPasswordException < StandardError; end
  class CannotChangePasswordException < StandardError; end
  belongs_to :client

  validates :client, :presence=>true

  def send_reset_password_instructions
    raise CannotResetPasswordException
  end
end
