class AddBillingAddressToClients < ActiveRecord::Migration
  def change
    add_column :clients, :billing_street_1, :string
    add_column :clients, :billing_street_2, :string
    add_column :clients, :billing_city, :string
    add_column :clients, :billing_state, :string
    add_column :clients, :billing_zip, :string
    
    add_column :buildings, :billing_street_1, :string
    add_column :buildings, :billing_street_2, :string
    add_column :buildings, :billing_city, :string
    add_column :buildings, :billing_state, :string
    add_column :buildings, :billing_zip, :string
  end
end
