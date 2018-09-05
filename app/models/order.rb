# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  scope :unpay, -> { where(status: 0) }
  scope :not_cart, -> { where('status IN (1, 2)') }

  def self.search(term, status)
    if term
      joins(:user).where("LOWER(first_name) LIKE CONCAT('%',CONVERT('#{term.mb_chars.downcase}',BINARY), '%')").order('id DESC')
    elsif status
      where('status = ?', status).order('id DESC')
    else
      order('id DESC')
    end
  end
end
