# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OnlineAuction
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.autoload_paths += %w[#{config.root}/app/models/ckeditor]
    config.autoload_paths << "#{Rails.root}/lib"
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.time_zone = 'Asia/Ho_Chi_Minh'
    config.active_record.default_timezone = :utc
    config.assets.enabled = true

    if defined?(Rails::Server)
      config.after_initialize do
        Rails.application.load_tasks
        Rake::Task['init_data:send_data'].invoke
      end
    end

    config.cache_store = :redis_store, {
      host: '127.0.0.1',
      port: 6379,
      db: 0
    }, { expires_in: 7.days }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
