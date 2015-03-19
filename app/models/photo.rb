class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :tags
  has_many :tagged_users, class_name: "User", foreign_key: "user_id", through: :tags

  has_attached_file :photo, styles: { medium: "300", thumb: "100x100#" }
  validates_attachment :photo, presence: true, content_type: {content_type: /\Aimage/}

end
