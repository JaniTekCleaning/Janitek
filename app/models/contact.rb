class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :content, :member, :subject, :client

  validates :member, :presence=>true
  validates :content, :presence=>true, :length=>{:minimum=>10, :maximum=>1000}
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end