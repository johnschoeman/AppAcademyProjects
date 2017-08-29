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

class Comment < ApplicationRecord
  validates :body, :author, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :User
end
