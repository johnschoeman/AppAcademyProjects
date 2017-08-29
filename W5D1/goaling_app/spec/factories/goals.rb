# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  details    :string
#  private    :boolean          default(FALSE), not null
#  finished   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    user_id 1
    title "MyString"
    description "MyString"
    pirvate false
    finished false
  end
end
