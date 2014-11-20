require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'validation' do
    setup do
      @user=Fabricate.build(:user)
    end
    should 'succeed' do
      assert @user.valid?
    end
    should 'fail on duplicate email addresses' do
      @user.save
      user2=Fabricate.build(:user, :email=>@user.email)
      assert user2.invalid?
    end
    should 'require first_name' do
      @user.first_name=nil
      assert @user.invalid?
    end
    should 'require last_name' do
      @user.last_name=nil
      assert @user.invalid?
    end
  end
end
