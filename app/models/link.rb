class Link < ActiveRecord::Base
  belongs_to :client

  has_attached_file :s3, :url => ":s3_domain_url", :path=>"/:class/:attachment/:id_partition/:style/:filename"

  validates_attachment_file_name :s3, :matches => [/pdf\Z/]

  validate :url_or_attachment

  def url_or_attachment
    unless ( !url.blank? ^ s3.file? )
        errors.add(:base, "You may enter an url or upload a file, not both")
      end
  end

  def url_to_use
    s3.file? ? s3.url : url
  end
end
