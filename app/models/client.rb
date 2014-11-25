class Client < ActiveRecord::Base
  include Filterable
  serialize :hot_button_items, Array

  validates :name, :presence=>true
  validates :number, :presence=>true
  validates :email, :presence=>true

  has_many :members
  has_many :contracts
  has_many :schedules

  scope :by_name, -> (name){ where "lower(name) LIKE ?", "%#{name.downcase}%"}
end
