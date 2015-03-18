require 'rails_helper'

describe 'the add user process' do

  it 'adds a new user with valid input' do
    go_home
    create_a_new_user
    expect(page).to have_content 'testuser1'
  end

  it 'adds a new user with invalid input' do
    go_home
    click_on 'Register'
    fill_in 'Username', with: 'testuser1'
    fill_in 'Password', with: 'pass'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Create User'
    expect(page).to_not have_content 'testuser1'
  end

end

describe 'the list users process' do

  it 'lists users with working links on home page' do
    go_home
    create_a_new_user
    go_home
    click_on 'testuser1'
    expect(page).to have_content 'testuser1'
  end

end


def create_a_new_user
  click_on 'Register'
  fill_in 'Username', with: 'testuser1'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  click_on 'Create User'
end

def go_home
  visit '/'
end
