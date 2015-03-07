class AddTitleAndCellToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :cell, :string
    rename_column :users, :number, :office
  end
end
