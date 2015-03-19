require 'rails_helper'

describe Photo do
  it { should belong_to :user }
  it { should have_attached_file :photo }
  it { should validate_attachment_content_type :photo }
  it { should have_many(:tagged_users).class_name('User').with_foreign_key(:user_id).through(:tags) }
end
