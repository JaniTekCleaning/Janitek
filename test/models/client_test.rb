require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  context 'validation' do
    setup do
      @client=Fabricate.build(:client)
    end
    should 'succeed' do
      assert @client.valid?
    end
    should 'require name' do
      @client.name=nil
      assert @client.invalid?
    end
    should 'require number' do
      @client.number=nil
      assert @client.invalid?
    end
    should 'require email' do
      @client.email=nil
      assert @client.invalid?
    end
  end
end
