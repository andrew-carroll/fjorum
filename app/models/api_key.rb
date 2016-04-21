class ApiKey < ActiveRecord::Base
  before_create :generate_key
  belongs_to :user
  def revoke!
    self.revoked = true
    self.save!
  end

  def active?
    !(expired? || revoked?)
  end

  def expired?
    Time.now >= self.expiration
  end

  private
  def generate_key
    begin
      self.key = RandomKey.generate!
    end while ApiKey.exists?(key: self.key)
  end

  module RandomKey
    def self.generate!
      SecureRandom.hex
    end
  end
end
