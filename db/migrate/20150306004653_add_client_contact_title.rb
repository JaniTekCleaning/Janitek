class AddClientContactTitle < ActiveRecord::Migration
  def change
    add_column :clients, :contacttitle, :string
  end
end
