# frozen_string_literal: true

module Admin::UsersHelper
  def load_role
    [['Thành viên', :member], ['Admin', :admin]]
  end
end
