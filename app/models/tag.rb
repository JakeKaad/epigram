class Tag < ActiveRecord::Base
  belongs_to :tagged_user, class_name: "User", foreign_key: :user_id
  belongs_to :tagged_photo, class_name: "Photo", foreign_key: :photo_id
end
