# frozen_string_literal: true

namespace :auction do
  desc 'Publish auction to channel'
  task publish_auction: :environment do
    set_interval(1) do
      auctions = $redis.keys('*')
      auctions.each do |auction|
        data = JSON.parse($redis.get(auction))
        ActionCable.server.broadcast("auction_#{auction}_channel", obj: data)
      end
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
