# == Schema Information
#
# Table name: user_comments
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer          not null
#

class UserComment < ApplicationRecord

  validates :body, :commented_user, :author, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :User

  belongs_to :commented_user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User
end
