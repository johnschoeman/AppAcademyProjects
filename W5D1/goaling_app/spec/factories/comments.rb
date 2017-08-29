# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :string           not null
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  author_id        :integer          not null
#

FactoryGirl.define do
  factory :comment do
    body "MyString"
    commentable_id 1
    commentalbe_type "MyString"
  end
end
