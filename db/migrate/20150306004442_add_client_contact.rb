class AddClientContact < ActiveRecord::Migration
  def change
    add_column :clients, :contact, :string
  end
end
