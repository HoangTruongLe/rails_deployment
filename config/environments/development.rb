Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  Paperclip.options[:command_path] = "/usr/bin/"

  # Configure working hours
  WorkingHours::Config.working_hours = {
      :mon => {'08:30' => '12:00', '13:00' => '17:30'},
      :tue => {'08:30' => '12:00', '13:00' => '17:30'},
      :wed => {'08:30' => '12:00', '13:00' => '17:30'},
      :thu => {'08:30' => '12:00', '13:00' => '17:30'},
      :fri => {'08:30' => '12:00', '13:00' => '17:30'}
  }

  # Configure timezone (uses activesupport, defaults to UTC)
  WorkingHours::Config.time_zone = 'Hanoi'

  # Configure holidays
  # WorkingHours::Config.holidays = [Date.new(2014, 12, 31)]
  ENV['REQUEST_MEMBER'] = 'http://localhost:3000/request_offs'
  ENV['REQUEST_ADMIN'] = 'http://localhost:3000/admin/request_offs'
  ENV['API_CHATWORK'] = 'b66d04e4c475f847b3ad0f9c8e2108da'
  ENV['ROOM_ID'] = '80268381'
end
