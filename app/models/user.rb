class User < ActiveRecord::Base
  include Filterable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, 
    :trackable, :validatable, :lockable
  enum role: [:user, :staff, :admin]

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_attached_file :avatar, :url => ":s3_domain_url", styles:{
    thumb:'50x50>',
    profile: '200x200'
    }, :path=>"/:class/:attachment/:id_partition/:style/:filename"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def full_name
    first_name + ' ' + last_name
  end
end
