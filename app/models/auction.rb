# frozen_string_literal: true

class Auction < ApplicationRecord
  after_destroy :remove_from_redis

  belongs_to :product
  has_many :auction_details, dependent: :destroy

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :bid_step, presence: true, numericality: { greater_than_or_equal_to: 1000 }
  validates :period, presence: true
  validate :end_at_must_greater_than_start_at
  validate :start_at_must_greater_or_equal_eight_clock

  scope :is_active, -> { where('status = 1') }

  def end_at_must_greater_than_start_at
    if self.end_at < self.start_at
      errors[:end_at] << 'phải lớn hơn thời gian bắt đầu'
      false
    else
      true
    end
  end

  def start_at_must_greater_or_equal_eight_clock
    if format_time_to_s(self.start_at) < 28800
      errors[:start_at] << 'phải lớn hơn hoặc bằng 8 giờ sáng'
      false
    else
      true
    end
  end

  def end_at_must_less_or_equal_twenty_two_clock
    if format_time_to_s(self.end_at) > 79200
      errors[:end_at] << 'phải nhỏ hơn hoặc bằng 10 giờ tối'
      false
    else
      true
    end
  end

  def remove_from_redis
    $redis.del(self.id)
  end

  def format_time_to_s(time)
    time = time.strftime('%H:%M:%S').split(':')
    time[0].to_i * 3600 + time[1].to_i * 60 + time[2].to_i
  end
end
