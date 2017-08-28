require 'spec_helper'
require 'rails_helper'

feature 'the create a goal process' do
  scenario 'has a new goal page'

  feature 'it can create a new goal'
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
    context 'user is viewing their own page' do

    end

    context 'user is viewing another user\'s page' do

    end
  end
end
