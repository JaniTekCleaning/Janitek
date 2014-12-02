require 'test_helper'

class ActionLogTest < ActiveSupport::TestCase
  context 'validation' do
    setup do
      @user=Fabricate(:user)
      @log=Fabricate.build(:action_log, :user=>@user)
    end
    should 'succeed' do
      assert @log.valid?
    end
    should 'require name' do
      @log.controller=nil
      assert @log.invalid?
    end
    should 'require number' do
      @log.action=nil
      assert @log.invalid?
    end
    should 'require email' do
      @log.user=nil
      assert @log.invalid?
    end
  end
end
