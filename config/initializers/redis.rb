# frozen_string_literal: true

$redis = Redis::Namespace.new 'demo-redis', redis: Redis.new
