class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.references :client, index: true
      t.string :type

      t.timestamps
    end
  end
end
