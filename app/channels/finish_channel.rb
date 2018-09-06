# frozen_string_literal: true

class FinishChannel < ApplicationCable::Channel
  def subscribed
    stream_from "finish_#{params[:auction_id]}_channel"
  end
end
