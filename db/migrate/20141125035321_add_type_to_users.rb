class AddTypeToUsers < ActiveRecord::Migration
  def up
    add_column :users, :type, :string
    add_column :users, :admin, :boolean

    User.reset_column_information

    User.all.each do |user|
      if user.role==0
        user.type='Member'
      else
        user.type='Staff'
        user.admin=true if user.role==2
      end
      user.save
    end

    remove_column :users, :role, :integer
  end
  
  def down
    add_column :users, :role, :integer
    User.reset_column_information

    User.all.each do |user|
      if user.type=="Member"
        user.role=0
      else
        if user.admin
          user.role=2
        else
          user.role=1
        end
      end
      user.save
    end
    remove_column :users, :type, :string
    remove_column :users, :admin, :boolean
  end
end
