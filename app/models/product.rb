# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true
  validates :detail, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :period, numericality: { greater_than_or_equal_to: 0 }
  validates :bid_step, numericality: { greater_than_or_equal_to: 0 }

  def self.search(term)
    if term
      where("LOWER(name) LIKE CONCAT('%',CONVERT('#{term.mb_chars.downcase}',BINARY), '%')").order('id DESC')
    else
      order('id DESC')
    end
  end
end
