# frozen_string_literal: true

module Admin::AdminHelper
  def show_errors(form, field)
    if form.object.errors[field].present?
      form.object.errors[field].each do |er|
        concat content_tag(:p, er, class: 'error-block')
      end
    end
  end
end
