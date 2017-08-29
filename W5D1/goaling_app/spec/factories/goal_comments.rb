# == Schema Information
#
# Table name: goal_comments
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  goal_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer          not null
#

FactoryGirl.define do
  factory :goal_comment do
    body "MyString"
    goal_id 1
  end
end
