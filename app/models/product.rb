# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  has_many :auctions, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items

  validates :name, presence: true, length: { maximum: 65 }
  validates :description, presence: true, length: { minimum: 80 }
  validates :detail, presence: true, length: { minimum: 80 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :is_online, -> { joins(:auctions).where('auctions.status = 1') }
  scope :in_cart, -> { joins(:line_items).where('line_items.order_id IN (SELECT id FROM orders WHERE status < 2)') }
  scope :in_categories, ->(cat_ids) { where('category_id IN (?)', cat_ids) }

  def self.search(term)
    if term
      where("LOWER(name) LIKE CONCAT('%',CONVERT('#{term.mb_chars.downcase}',BINARY), '%')").order('id DESC')
    else
      order('id DESC')
    end
  end
end
