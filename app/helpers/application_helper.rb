# frozen_string_literal: true

module ApplicationHelper
  def format_time_to_seconds(time)
    time = time.strftime('%H:%M:%S').split(':')
    time[0].to_i * 3600 + time[1].to_i * 60 + time[2].to_i
  end
end
