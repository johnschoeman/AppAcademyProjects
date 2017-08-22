# == Schema Information
#
# Table name: artwork_shares
#
#  id         :integer          not null, primary key
#  artwork_id :integer          not null
#  viewer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArtworkShare < ApplicationRecord
  validates :viewer_id, :artwork_id, presence: true
  validates :viewer_id, uniqueness: { scope: :artwork_id,
    message: "The same user can't view the same artwork more than once." }

  belongs_to :artwork,
    foreign_key: :artwork_id,
    primary_key: :id,
    class_name: :Artwork

  belongs_to :viewer,
    foreign_key: :viewer_id,
    primary_key: :id,
    class_name: :User

end
