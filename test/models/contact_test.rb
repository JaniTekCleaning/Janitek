require 'test_helper'

class ContextTest < ActiveSupport::TestCase

  context 'validation' do
    setup do
      @client=Fabricate(:client)
      @member=Fabricate(:member, :client=>@client)
      @contact=Fabricate.build(:contact,:member=>@member)
    end
    should 'succeed' do
      assert @contact.valid?
    end
    should 'require member' do
      @contact.member=nil
      assert @contact.invalid?
    end
    should 'require content' do
      @contact.content=nil
      assert @contact.invalid?
    end
  end
end
