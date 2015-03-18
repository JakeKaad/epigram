require 'rails_helper'

describe Photo do
  it { should belong_to :user }
  it { should have_attached_file :photo }
  it { should validate_attachment_content_type :photo }
end
