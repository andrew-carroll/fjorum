require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase
  it 'generates a random key upon initialization' do
    SecureRandom.stub(:hex, "testkey") do
      api_key = ApiKey.new
      assert_equal "testkey", api_key.key
    end
  end
end
