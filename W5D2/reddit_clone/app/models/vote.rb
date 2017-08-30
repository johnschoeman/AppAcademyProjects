# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  value        :integer          not null
#  votable_type :string
#  votable_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  owner_id     :integer
#

class Vote < ApplicationRecord
  validates :value, presence: true, inclusion: { in: [1, -1] }
  validates :votable_id, uniqueness: { scope: [:votable_type, :owner_id] }

  belongs_to :votable, polymorphic: true
  belongs_to :owner,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: :User
end
