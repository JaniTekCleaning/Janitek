class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.references :client, index: true, foreign_key: true
      t.string :name
      t.string :number
      t.string :email
      t.text :hot_button_items
      t.integer :staff_id
      t.string :directnumber
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip
      t.text :notes
      t.string :contact
      t.string :contacttitle
    end

    add_foreign_key :buildings, :users, column: :staff_id, primary_key: :id
  end
end
