class AddAttachmentToUrl < ActiveRecord::Migration
  def up
    add_attachment :links, :s3
  end
  def down
    remove_attachment :links, :s3
  end
end
