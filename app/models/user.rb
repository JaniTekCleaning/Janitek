class User < ActiveRecord::Base
  include Filterable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, 
    :trackable, :validatable, :lockable
  enum role: [:user, :staff, :admin]

  validates :first_name, presence: true
  validates :last_name, presence: true

end
