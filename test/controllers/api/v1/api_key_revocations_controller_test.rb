require 'test_helper'

class Api::V1::ApiKeyRevocationsControllerTest < ActionController::TestCase
  describe '#create' do
    let(:api_key) { api_keys(:base) }
    context 'given a valid API key' do
      context 'not expired or revoked' do
        it 'renders status: 201 Created' do
          post :create, api_key: api_key.key
          assert_response :created
        end
        it 'revokes the API key' do
          refute api_key.revoked?, "API key should still be valid"
          post :create, api_key: api_key.key
          assert api_key.reload.revoked?, "API key should have been revoked"
        end
      end
      context 'expired' do
        let(:api_key) { api_keys(:expired) }
        it 'renders error: 404 Not Found' do
          post :create, api_key: api_key.key
          assert_response :not_found
        end
      end
      context 'revoked' do
        let(:api_key) { api_keys(:revoked) }
        it 'renders error: 404 Not Found' do
          post :create, api_key: api_key.key
          assert_response :not_found
        end
      end
    end
    context 'given an invalid API key' do
      it 'renders error: 404 Not Found' do
        post :create, api_key: "invalid key"
        assert_response :not_found
      end
    end
  end
end
