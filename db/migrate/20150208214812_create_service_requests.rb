class CreateServiceRequests < ActiveRecord::Migration
  def change
    create_table :service_requests do |t|
      t.text :fields, null:false

      t.timestamps
    end
  end
end
