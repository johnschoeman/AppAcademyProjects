require 'spec_helper'
require 'rails_helper'

feature 'the create a goal comment process' do
  before :each do
    user1 = User.create(username: 'bob', password: 'password')
    user2 = User.create(username: 'cob', password: 'password')
    user2goal = Goal.create(user: user2, title: 'cob\'s goal')
    sign_in(user1)
    visit goal_url(user2goal)
  end

  it 'has an add comment on a goal\'s page' do
    expect(page).to have_content 'Add Comment'
  end

  it 'can add a comment to the goal page' do
    fill_in 'Comment', with: 'a serious goal comment'
    click_button 'Add Comment'
    expect(page).to have_content 'a serious goal comment'
  end

end
