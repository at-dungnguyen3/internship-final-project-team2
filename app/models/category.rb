# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :childs, foreign_key: 'categories_id', class_name: Category.name, dependent: :destroy
  belongs_to :parent, foreign_key: 'categories_id', class_name: Category.name, optional: true

  validates :name, presence: true, uniqueness: { scope: :categories_id }

  scope :another_categories, ->(id) { where('id != ?', id) }
  scope :is_parent, -> { where categories_id: nil }

  def self.search(term)
    if term
      where("LOWER(name) LIKE CONCAT('%',CONVERT('#{term.mb_chars.downcase}',BINARY), '%')").order('id DESC')
    else
      where('categories_id IS NULL').order('id DESC')
    end
  end

  def check_parent?
    category = Category.find_by(id: self.categories_id)
    return true unless category
    category.parent.nil?
  end
end
