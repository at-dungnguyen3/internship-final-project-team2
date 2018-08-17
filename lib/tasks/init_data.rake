# frozen_string_literal: true

require 'backgrounds/auction_data'

namespace :init_data do
  desc 'send data to channel'
  task send_data: :environment do
    AuctionData.send_data_to_redis
    set_interval(1) do
      data = []
      auction_keys = $redis.keys('*')
      auction_keys.each do |key|
        AuctionData.new.push_data(key, data)
      end
      ActionCable.server.broadcast 'home_channel', obj: data
    end
  end
end

def set_interval(delay)
  mutex = Mutex.new
  Thread.new do
    mutex.synchronize do
      loop do
        sleep delay
        yield
      end
    end
  end
end
