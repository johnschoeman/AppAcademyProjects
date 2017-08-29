# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { User.new(username: 'bob', password: 'password') }

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it do
      should validate_length_of(:password)
        .is_at_least(6)
        .on(:create)
    end
  end

  describe 'associations' do
    it { should have_many(:goals) }
    it 'should have many comments'
  end

  describe 'class methods' do

    describe '::find_by_credentials' do
      it 'should return nil if bad credentials are given' do
        User.create(username: 'bob', password: 'password')
        user = User.find_by_credentials('bob', "not_the_right_password")
        expect(user).to be_nil
      end

      it 'should return the user if good credentials are given' do
        User.create(username: 'bob', password: 'password')
        user = User.find_by_credentials("bob", "password")
        expect(user.username).to eq('bob')
      end
    end
  end

end
