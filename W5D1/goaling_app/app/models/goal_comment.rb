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

class GoalComment < ApplicationRecord
  validates :body, :commented_goal, presence: true

  belongs_to :commented_goal,
    foreign_key: :goal_id,
    primary_key: :id,
    class_name: :Goal
end
