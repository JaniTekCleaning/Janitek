class ConnectModelsToBuildings < ActiveRecord::Migration
  def up
    add_reference :links, :building

    create_table :buildings_members do |t|
      t.references :building
      t.integer :member_id
    end

    add_foreign_key :buildings_members, :users, column: :member_id, primary_key: :id

    Client.all.each do |client|
      building = Building.new(client:client)
      building.name = client.name
      building.name = client.name
      building.number = client.number
      building.email = client.email
      building.hot_button_items = client.hot_button_items
      building.staff_id = client.staff_id
      building.directnumber = client.directnumber
      building.street1 = client.street1
      building.street2 = client.street2
      building.city = client.city
      building.state = client.state
      building.zip = client.zip
      building.notes = client.notes
      building.contact = client.contact
      building.contacttitle = client.contacttitle
      building.save!

      building.members << client.members

      Link.where(client_id: client.id).each do |link|
        link.building_id = building.id
      end
    end

    remove_reference :links, :client
  end

  def down
    add_reference :links, :client

    Building.all.each do |building|
      Link.where(building_id: building.id).each do |link|
        link.client_id = building.client_id
      end
      building.destroy!
    end

    drop_table :buildings_members

    remove_reference :links, :building
  end
end
