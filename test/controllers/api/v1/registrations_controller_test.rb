require 'test_helper'

class Api::V1::RegistrationsControllerTest < ActionController::TestCase
  describe '#create' do
    context 'with an email address and password' do
      let(:params) { {email: "foo@bar.com", password: "hunter2"} }
      it 'renders status: 201 Created' do
        post :create, registration: params
        assert_response :created
      end
      it 'creates a User' do
        refute User.exists?(email: "foo@bar.com"), "User shouldn't exist yet"
        post :create, registration: params
        assert User.exists?(email: "foo@bar.com"), "User should have been created"
      end
    end
    context 'with a password but no email address' do
      let(:params) { {password: "hunter2"} }
      it 'renders error: 400 Bad Request' do
        post :create, registration: params
        assert_response :bad_request
      end
    end
    context 'with an email address but no password' do
      let(:params) { {email: "foo@bar.com"} }
      it 'renders error: 400 Bad Request' do
        post :create, registration: params
        assert_response :bad_request
      end
    end
  end
end
