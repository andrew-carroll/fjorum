require 'test_helper'

class Api::V1::ApiKeysControllerTest < ActionController::TestCase
  describe '#create' do
    context 'given an email address and password' do
      context 'which are valid' do
        let(:params) { {email: "foo@bar.com", password: "hunter2"} }
        before { User.create!(params) }
        it 'renders status: 201 Created' do
          post :create, credentials: params
          assert_response :created
        end
        it 'responds with the created API key' do
          ApiKey::RandomKey.stub(:generate!, "testkey") do
            post :create, credentials: params
          end
          assert_equal JSON.parse(response.body), {"key" => "testkey"}
        end
      end
      context 'which are invalid' do
        let(:params) { {email: "foo@bar.com", password: "fakepw"} }
        it 'renders status: 401 Unauthorized' do
          post :create, credentials: params
          assert_response :unauthorized
        end
      end
    end
    context 'given an email address but no password' do
      let(:params) { {email: "foo@bar.com"} }
      it 'renders error: 400 Bad Request' do
        post :create, credentials: params
        assert_response :bad_request
      end
    end
    context 'given a password but no email address' do
      let(:params) { {email: "foo@bar.com"} }
      it 'renders error: 400 Bad Request' do
        post :create, credentials: params
        assert_response :bad_request
      end
    end
  end
end
