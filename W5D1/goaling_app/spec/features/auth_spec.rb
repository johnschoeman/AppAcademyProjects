
require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'New User'
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
      sign_up_bob
      expect(page).to have_content 'bob'
    end

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    sign_in_bob
    expect(page).to have_content 'bob'
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit new_session_url
    expect(page).not_to have_content 'Log Out'
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    User.create(username: 'bob', password: 'password')

    # Sign In User
    visit new_session_url
    fill_in 'Username', with: 'bob'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    # Sign Out User
    click_button 'Sign Out'
    expect(page).not_to have_content 'bob'
  end

end
