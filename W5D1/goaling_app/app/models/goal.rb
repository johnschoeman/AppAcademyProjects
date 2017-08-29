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

class Goal < ApplicationRecord
  validates :user, :title, presence: true
  validates :private, :finished, inclusion: { in: [true, false] }

  belongs_to :user

  has_many :comments, as: :commentable
end
