class Link < ActiveRecord::Base
  belongs_to :client

  validates :url, :presence=>true
end
