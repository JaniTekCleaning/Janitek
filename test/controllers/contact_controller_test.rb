require 'test_helper'

class ContactControllerTest < ActionController::TestCase
  setup do
    @member=Fabricate(:member, :client=>Fabricate(:client))
    sign_in @member
  end
  should 'get new' do
    get :new
    assert_response :success
  end
  should 'send email' do
    post :create, :contact=>{:content=>'abcdef'}
    pending("email response")
  end
end
