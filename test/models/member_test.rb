require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  setup do
    @client=Fabricate(:client)
    @member=Fabricate(:member, :client=>@client)
  end
  should 'require client' do
    @member.client=nil
    assert @member.invalid?
  end
end
