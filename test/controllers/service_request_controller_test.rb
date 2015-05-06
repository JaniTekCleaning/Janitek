require 'test_helper'

class ServiceRequestControllerTest < ActionController::TestCase
  context 'authenticated as member' do
    setup do
      @client=Fabricate(:client)
      @member = Fabricate(:member, :client=>@client)
      @service_request=Fabricate(:service_request)
      sign_in @member
    end
    should 'get show' do
      get :show
      assert_response :success
    end
    context 'posting submit' do
      context 'succeeds' do
        should 'redirect to root' do
          post :submit, {:form_version=>@service_request.version_number, formField:{'0':'abcd'}}
          assert_redirected_to root_path
        end
        should 'send email' do
          message=mock('mailer')
          ContactMailer.expects(:service_request).returns(message)
          message.expects(:deliver_now)
          post :submit, {:form_version=>@service_request.version_number, formField:{'0':'abcd'}}
        end
      end
      context 'invalid version numer' do
        should 'redirect to form' do
          post :submit, {}
          assert_redirected_to service_request_path
        end
      end
    end
    should 'not get edit' do
      assert_raises(Pundit::NotAuthorizedError){get :edit}
    end
    should 'not put update' do
      assert_raises(Pundit::NotAuthorizedError){put :update}
    end
  end
  context 'authenticated as staff' do
    setup do
      sign_in Fabricate(:staff)
    end
    should 'be redirected from show' do
      get :show
      assert_redirected_to service_request_edit_path
    end
    should 'be redirected from submit' do
      post :submit
      assert_redirected_to service_request_edit_path
    end
    should 'get edit' do
      get :edit
      assert_response :success
    end
    context 'update' do
      should 'put update' do
        # put :update, :variable_item=>[]
        assert_response :success
      end
      should 'create version number' do
        put :update, {service_item_title:{'0':'item'}, service_item_type:{'0':'shortText'} }
        assert ServiceRequest.first.version_number==1
      end
    end
  end
end
