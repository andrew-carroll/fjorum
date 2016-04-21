require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  it 'generates a random key upon creation' do
    user = users(:morty)
    api_key = user.api_keys.new
    refute api_key.key, "Key should not have been generated yet"
    SecureRandom.stub(:hex, "testkey") do
      api_key.save!
    end
    assert api_key.key, "Key should have been generated"
    assert_equal "testkey", api_key.key
  end
  describe '#expired?' do
    context 'when the expiration time has past' do
      let(:api_key) { api_keys(:expired) }
      it 'returns true' do
        assert api_key.expired?
      end
    end
    context 'when the expiration time has not passed yet' do
      let(:api_key) { api_keys(:base) }
      it 'returns false' do
        refute api_key.expired?
      end
    end
  end
  describe '#active?' do
    let(:api_key) { api_keys(:base) }
    context 'when not expired or revoked' do
      it 'returns true' do
        assert api_key.active?
      end
    end
    context 'when revoked' do
      let(:api_key) { api_keys(:revoked) }
      it 'returns false' do
        refute api_key.active?
      end
    end
    context 'when expired' do
      let(:api_key) { api_keys(:expired) }
      it 'returns false' do
        refute api_key.active?
      end
    end
  end
  describe '#revoke!' do
    let(:api_key) { api_keys(:base) }
    it 'revokes the API key' do
      refute api_key.revoked?, "API key should not have been revoked yet"
      api_key.revoke!
      assert api_key.revoked?, "API key should have been revoked"
    end
  end
end
