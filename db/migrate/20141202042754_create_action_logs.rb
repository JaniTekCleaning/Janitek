class CreateActionLogs < ActiveRecord::Migration
  def change
    create_table :action_logs do |t|
      t.string :controller
      t.string :action
      t.references :user, index: true

      t.timestamps
    end
  end
end
