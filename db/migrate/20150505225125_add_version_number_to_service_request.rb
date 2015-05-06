class AddVersionNumberToServiceRequest < ActiveRecord::Migration
  def up
    add_column :service_requests, :version_number, :integer
    ServiceRequest.all.each{|item| item.destroy}
  end

  def down
    remove_column :service_requests, :version_numer
  end
end
