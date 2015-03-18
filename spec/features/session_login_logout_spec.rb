require 'rails_helper'

describe 'the user login process' do

  it 'logs user in with valid input' do
    go_home
    create_a_new_user
    logout
    login
    expect(page).to have_content 'testuser1'
  end

  it 'does not log user in when invalid input' do
    go_home
    create_a_new_user
    logout
    click_on 'Login'
    fill_in 'Username', with: 'testuser1'
    fill_in 'Password', with: 'wrong_password'
    click_button 'Login'
    expect(page).to_not have_content 'testuser1'
  end

end


def create_a_new_user
  click_on 'Register'
  fill_in 'Username', with: 'testuser1'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  click_on 'Create User'
end

def login
  click_on 'Login'
  fill_in 'Username', with: 'testuser1'
  fill_in 'Password', with: 'password'
  click_button 'Login'
end

def logout
  click_on 'Logout'
end

def go_home
  visit '/'
end
