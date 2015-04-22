class ServiceRequest < ActiveRecord::Base
  serialize :fields, Array
  validates :fields, :presence=>true
  
  def select_field(field)
    return nil unless field && fields.count > 0
    field=field.to_i
    raise Exception.new "Field out of range" if field < 0 || field > fields.count - 1
    fields[field]
  end
end
