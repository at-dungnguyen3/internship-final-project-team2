# frozen_string_literal: true

class Picture < ApplicationRecord
  belongs_to :product
  mount_uploader :image, PictureUploader

  validate :image_size

  private

    def image_size
      errors.add(:image, 'lớn hơn 5MB') if image.size > 5.megabytes
    end
end
