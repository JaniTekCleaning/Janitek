class Member < User
  class CannotResetPasswordException < StandardError; end
  class CannotChangePasswordException < StandardError; end
  belongs_to :client

  validates :client, :presence=>true

  has_and_belongs_to_many :buildings, foreign_key: :member_id, join_table: :buildings_members

  def send_reset_password_instructions
    raise CannotResetPasswordException
  end
end
