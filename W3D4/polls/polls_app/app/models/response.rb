# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'byebug'

class Response < ApplicationRecord

  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    foreign_key: :answer_choice_id,
    primary_key: :id

  belongs_to :respondent,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    q = question
    sib_responses = q.responses
    sib_responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    siblings = self.sibling_responses
    user = respondent
    user_id = user.id
    siblings.any? do |sibling|
      sibling.user_id == user_id
    end
  end
end
