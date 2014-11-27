class AddJanitorialLeadToClient < ActiveRecord::Migration
  def change
    add_reference :clients, :staff, index: true
  end
end
