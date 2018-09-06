# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Account activation'
  end

  def order_confirmation(user, order)
    @user = user
    @order = order
    mail to: user.email, subject: 'Order confirmation'
  end
end
