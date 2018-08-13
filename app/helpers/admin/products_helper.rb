# frozen_string_literal: true

module Admin::ProductsHelper
  def select_childs_categories
    Category.where('categories_id IS NOT NULL').collect { |cat| [cat.name, cat.id] }
  end

  def link_to_add_fields(name, f, association, _opts = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\");return false;"), class: 'btn btn-success add_file_fields')
  end

  def link_to_function(name, js, opts = {})
    link_to name, '#', opts.merge(onclick: js)
  end
end
