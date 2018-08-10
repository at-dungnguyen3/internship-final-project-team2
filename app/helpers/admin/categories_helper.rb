# frozen_string_literal: true

module Admin::CategoriesHelper
  def select_categories(id)
    id ||= 0
    Category.is_parent.another_categories(id).collect { |cat| [cat.name, cat.id] }
  end

  def parent_cat_name(id)
    category = Category.find_by(id: id)
    return category.name if category
    'Danh mục cha'
  end

  def link_to_if_has_childs(category)
    if category.childs.any?
      link_to category.name, admin_category_path(category.id)
    else
      category.name
    end
  end
end
