class User < ActiveRecord::Base
  has_secure_password
  has_many :api_keys
  has_many :posts
end
