require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Sidekiq::Extensions.enable_delay!

module Meal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{config.root}/lib)
  end
end

Raven.configure do |config|
  config.dsn = 'https://5818f615d8b14ac89cf0825e4fe5e58f:33d5cdd65d4c428abfb7e987a2c1bf52@sentry.io/195167'
end