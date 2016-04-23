require 'test_helper'

class Api::V1::PostsControllerTest < ActionController::TestCase
  describe '#create' do
    let(:api_key) { api_keys(:base) }
    context 'with a message and valid API key' do
      it 'renders status: 201 Created' do
        post :create, api_key: api_key.key, message: 'valid'
        assert_response :created
      end
    end
    context 'without a message' do
      it 'renders error: 400 Bad Request' do
        post :create, api_key: api_key.key
        assert_response :bad_request
      end
    end
    context 'without an API key' do
      it 'renders error: 401 Unauthorized' do
        post :create, message: 'hello world'
        assert_response :unauthorized
      end
    end
    context 'with an invalid API key' do
      let(:api_key) { api_keys(:expired) }
      it 'renders error: 401 Unauthorized' do
        post :create, message: 'hello world', api_key: api_key
        assert_response :unauthorized
      end
    end
  end
end
