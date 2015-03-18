require 'rails_helper'

describe User do
  it { should have_many :photos }
  it { should validate_presence_of :username }
  it { should have_secure_password }
  it { should validate_length_of :password }
  it { should have_attached_file :avatar }
  it { should validate_attachment_content_type :avatar }
end
