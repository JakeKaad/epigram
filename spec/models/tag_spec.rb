require 'rails_helper'

describe Tag do
  it { should belong_to(:tagged_user).class_name("User").with_foreign_key(:user_id) }
  it { should belong_to(:tagged_photo).class_name("Photo").with_foreign_key(:photo_id) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:photo_id) }
end
