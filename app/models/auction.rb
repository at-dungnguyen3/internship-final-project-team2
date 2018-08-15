# frozen_string_literal: true

class Auction < ApplicationRecord
  belongs_to :product

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :bid_step, presence: true, numericality: { greater_than_or_equal_to: 1000 }
  validates :period, presence: true
  validate :end_at_must_greater_than_start_at

  def end_at_must_greater_than_start_at
    if self.end_at < self.start_at
      errors[:end_at] << 'Thời gian kết thúc phải lớn hơn thời gian bắt đầu'
      false
    else
      true
    end
  end
end
