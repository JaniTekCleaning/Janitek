require 'test_helper'

class ServiceRequestTest < ActiveSupport::TestCase
  context 'validation' do
    setup do
      @request=Fabricate.build(:service_request)
    end
    should 'validate' do
      assert @request.valid?
    end
    should 'require fields' do
      @request.fields=nil
      assert @request.invalid?
    end
  end
end
