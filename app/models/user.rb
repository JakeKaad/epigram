class User < ActiveRecord::Base
  has_many :photos
  validates :username, presence: true
  validates_uniqueness_of :username
  validates_length_of :password, minimum: 8
  has_secure_password
  has_attached_file :avatar, styles: { medium: "300", thumb: "100x100#" }
  validates_attachment :avatar, presence: true, content_type: {content_type: /\Aimage/}
end
