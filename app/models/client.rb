class Client < ActiveRecord::Base
  include Filterable
  serialize :hot_button_items, Array

  validates :name, :presence=>true
  validates :number, :presence=>true
  validates :email, :presence=>true

  has_many :members, dependent: :destroy
  has_many :buildings, dependent: :destroy
  belongs_to :staff

  scope :by_name, -> (name){ where "lower(name) LIKE ?", "%#{name.downcase}%"}
  scope :by_rep, -> (rep){ rep=="NULL" ? (where staff: nil) : (where staff: rep) }

  has_attached_file :logo, :url => ":s3_domain_url", styles:{
    thumb:'50x50>',
    profile: '200x200'
    }, :path=>"/:class/:attachment/:id_partition/:style/:filename"

  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end
