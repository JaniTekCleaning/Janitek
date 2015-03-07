class AddClientDirectNumberAndAddress < ActiveRecord::Migration
  def change
    add_column :clients, :directnumber, :string
    add_column :clients, :street1, :string
    add_column :clients, :street2, :string
    add_column :clients, :city, :string
    add_column :clients, :state, :string
    add_column :clients, :zip, :string
    add_column :clients, :notes, :text
  end
end
