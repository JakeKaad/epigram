class Photo < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo, styles: { medium: "300", thumb: "100x100#" }
  validates_attachment :photo, presence: true, content_type: {content_type: /\Aimage/}



end
