require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  setup do
    @link=Fabricate.build(:link)
  end
  should 'validate' do
    assert @link.valid?
  end
  should 'be valid with s3 file' do
    @link.url=nil
    @link.s3=File.new(Rails.root + 'test/fixtures/test_pdf.pdf')
    assert @link.valid?
  end
  should 'require either url or attachment' do
    @link.url=nil
    @link.s3=nil
    assert @link.invalid?
  end
end
