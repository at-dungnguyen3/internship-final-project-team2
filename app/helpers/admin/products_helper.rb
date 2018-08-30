# frozen_string_literal: true

module Admin::ProductsHelper
  def select_childs_categories
    Category.where('categories_id IS NOT NULL').collect { |cat| [cat.parent.name + ' --- ' + cat.name, cat.id] }
  end
end
