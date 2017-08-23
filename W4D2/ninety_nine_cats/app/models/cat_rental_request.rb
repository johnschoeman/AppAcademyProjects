# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate :does_not_overlap_approved_request

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat


  def deny!
    self.status = 'DENIED'
    self.save(validate: false) #skip validate overlapped approved requests
  end


  def approve!
    CatRentalRequest.transaction do
      self.update(status: 'APPROVED')
      # overlapping_pending_requests = overlapping_pending_requests
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def pending?
    self.status == 'PENDING'
  end

  private

  def overlapping_requests
    CatRentalRequest.where("cat_id = #{self.cat_id}")
    .where.not("('#{self.start_date}'::date < start_date AND '#{self.end_date}'::date < start_date) OR ('#{self.end_date}'::date > end_date AND '#{self.start_date}'::date > end_date)")
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def does_not_overlap_approved_request
    # return if self.status == 'DENIED'
    requests = overlapping_approved_requests
    unless requests.to_a.empty?
      errors[:rented] << "Cat already rented out during this time."
    end
  end
end
