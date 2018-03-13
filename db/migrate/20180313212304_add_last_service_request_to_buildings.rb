class AddLastServiceRequestToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :last_service_request, :text
  end
end
