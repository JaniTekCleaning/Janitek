class Building < ActiveRecord::Base
  belongs_to :staff
  belongs_to :client
  
  serialize :hot_button_items, Array
  serialize :last_service_request, JSON

  validates :name, :presence=>true
  validates :number, :presence=>true
  validates :email, :presence=>true
  validates :client, :presence=>true
  
  has_many :contracts, dependent: :destroy
  has_many :schedules, dependent: :destroy

  has_and_belongs_to_many :members, join_table: :buildings_members
end