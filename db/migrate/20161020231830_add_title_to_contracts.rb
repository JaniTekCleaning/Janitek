class AddTitleToContracts < ActiveRecord::Migration
  def change
    add_column :links, :title, :text

    Link.all.each do |link|
      link.update(title:link.created_at.strftime("%b %d, %Y"))
    end
  end
end
