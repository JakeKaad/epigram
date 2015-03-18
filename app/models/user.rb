class User < ActiveRecord::Base
  validates :username, presence: true
  validates_uniqueness_of :username
  validates_length_of :password, minimum: 8
  has_secure_password
end
