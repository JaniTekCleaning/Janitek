class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :number
      t.string :email, null:false 
      t.text :hot_button_items

      t.timestamps
    end

    add_column :users, :client_id, :integer
    add_index :users, :client_id
  end
end
