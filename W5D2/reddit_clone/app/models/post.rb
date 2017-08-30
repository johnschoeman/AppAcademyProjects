# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :author, presence: true
  validates :subs, length: { minimum: 1 }

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :User

  has_many :postings, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :postings

  has_many :comments

  has_many :votes, as: :votable

  def comments_by_parent_id
    comments = self.comments
    h = Hash.new {|h,k| h[k] = [] }
    comments.each do |comment|
      h[comment.parent_comment_id] << comment
    end
    h
  end
end
