class ApiKey < ActiveRecord::Base
  after_initialize :generate_key
  belongs_to :user
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
