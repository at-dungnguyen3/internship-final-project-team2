# frozen_string_literal: true

module Admin::UsersHelper
  def load_role
    [['Thành viên', :member], ['Admin', :admin]]
  end

  def load_activation
    [['Kích hoạt', true], ['Hủy kích hoạt', false]]
  end

  def show_activation_status(user)
    if user.activated?
      content_tag(:span, 'Đã kích hoạt', class: 'btn btn-success', onclick: "activate(#{user.id})")
    else
      content_tag(:span, 'Chưa kích hoạt', class: 'btn btn-default', onclick: "activate(#{user.id})")
    end
  end

  def show_role(user)
    if user.admin?
      content_tag(:span, 'Administrator')
    else
      content_tag(:span, 'Thành viên')
    end
  end
end
