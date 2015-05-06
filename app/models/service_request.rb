class ServiceRequest < ActiveRecord::Base
  serialize :fields, Array
  validates :fields, :presence=>true
end
