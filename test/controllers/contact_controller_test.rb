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
    message=mock('mailer')
    ContactMailer.expects(:contact_message).returns(message)
    message.expects(:deliver_now)
    post :create, :contact=>{:content=>'abcdef'*3}
  end
end
