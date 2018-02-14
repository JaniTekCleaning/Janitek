require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  context 'validation' do
    setup do
      @client=Fabricate.build(:client)
      @building=Fabricate.build(:building, client: @client)
    end
    should 'succeed' do
      assert @building.valid?
    end
    should 'require name' do
      @building.name=nil
      assert @building.invalid?
    end
    should 'require number' do
      @building.number=nil
      assert @building.invalid?
    end
    should 'require email' do
      @building.email=nil
      assert @building.invalid?
    end
  end
end
