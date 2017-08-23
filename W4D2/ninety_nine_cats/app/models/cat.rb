# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord
  COLORS = %w(orange blue green taco red)

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS, message: "Cat must be of an awesome color." }
  validates :sex, inclusion: { in: %w(M F), message: "Cat must be gender binary" }

  def age
    Time.now.year - self.birth_date.year
  end

  has_many :rental_requests,
    foreign_key: :cat_id,
    primary_key: :id,
    class_name: :CatRentalRequest,
    dependent: :destroy

end
