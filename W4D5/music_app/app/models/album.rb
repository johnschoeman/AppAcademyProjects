# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  title      :string           not null
#  yr         :integer          not null
#  live       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord
  validates :band_id, :title, :yr, presence: true
  validates :live, inclusion: { in: [true, false] }

  belongs_to :band
end
