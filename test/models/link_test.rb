require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  setup do
    @link=Fabricate(:link)
  end
  should 'validate' do
    assert @link.valid?
  end
  should 'require url' do
    @link.url=nil
    assert @link.invalid?
  end
end
