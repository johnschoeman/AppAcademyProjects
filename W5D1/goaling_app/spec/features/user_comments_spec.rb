require 'spec_helper'
require 'rails_helper'

feature 'the create a user comment process' do
  before :each do
    user1 = User.create(username: 'bob', password: 'password')
    user2 = User.create(username: 'cob', password: 'password')
    sign_in(user1)
    visit user_url(user2)
  end

  it 'has an add comment on a users\' page' do
    expect(page).to have_content 'Add Comment'
  end

  it 'can add a comment to the user page' do
    fill_in 'Comment', with: 'a serious comment'
    click_button 'Add Comment'
    expect(page).to have_content 'a serious comment'
  end

end

feature 'the delete a comment process' do
  before :each do
    user1 = User.create(username: 'bob', password: 'password')
    user2 = User.create(username: 'cob', password: 'password')
    sign_in(user1)
    visit user_url(user2)
    fill_in 'Comment', with: 'some random comment'
    click_button 'Add Comment'
  end

  it 'can delete a comment by clicking a delete button' do
    click_button 'delete comment'
    expect(page).not_to have_content 'some random comment'
  end

end
