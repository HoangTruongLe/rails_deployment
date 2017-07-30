require_relative 'boot'

require 'rails/all'
require "chatwork"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Requestoff
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.default_locale

    config.time_zone = 'Hanoi'
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.template_engine :slim
      g.assets    false
      g.decorator false
      g.helper    false
      g.test_framework :rspec,
                       controller_specs: false,
                       view_specs: false,
                       request_specs: false,
                       routing_specs: false
    end

  end
end
