# frozen_string_literal: true

class HomeChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'home_channel'
  end
end
