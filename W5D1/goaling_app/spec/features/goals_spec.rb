require 'spec_helper'
require 'rails_helper'

feature 'the create a goal process' do
  before :each do
    sign_in_bob
    visit new_goal_url
  end

  it 'has a new goal page' do
    expect(page).to have_content 'New Goal'
  end

  feature 'it can create a new goal' do
    it 'takes a title, details, private? and completed?' do
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Details'
      expect(page).to have_content 'Private?'
      expect(page).to have_content 'Completed?'
    end

    it 'redirectes to goal show page on success' do
      fill_in 'Title', with: 'My Awesome Goal'
      fill_in 'Details', with: 'Some Great Details'

      click_button 'New Goal'

      expect(current_path).to eq(goal_path(Goal.last))
    end

    context 'on a failed save' do
      before :each do
        fill_in 'Details', with: 'Another Awesome Goad'
        click_button 'New Goal'
      end

      it 'renders errors when invalid goals are submitted' do
        expect(page).to have_content 'Title can\'t be blank'
      end

      it 'displays the new goal form again' do
        expect(page).to have_content 'New Goal'
      end

      it 'has a pre-filled form (with the data previously input)' do
        expect(find_field('Details').value).to eq('Another Awesome Goad')
      end

      it 'still allows for a successful save' do
        fill_in 'Title', with: 'This is a Title'
        click_button 'New Goal'
        expect(current_path).to eq(goal_path(Goal.last))
      end
    end
  end
end

feature 'the view a goal process' do
  scenario 'has a goal show page'

end

feature 'the update a goal process' do
  scenario 'has an edit goal page'

  feature 'it can update a goal'
end

feature 'the delete a goal process' do
  feature 'user can delete a goal'
end

feature 'the viewing of a user\'s goals on a user\'s page' do
  scenario 'has goals listed on user\'s page' do

  end
end
