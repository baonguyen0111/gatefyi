Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.action_mailer.show_previews = true
  config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"
  #host = 'localhost:3000'
  #config.action_mailer.default_url_options = { :host => 'localhost:3000', protocol: 'http' }
   config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
   config.action_mailer.delivery_method = :smtp
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.hosts << "33aa658ff75040b687078a689fbe875c.vfs.cloud9.us-east-1.amazonaws.com"
  config.hosts << "042be2d3ab744762900fbbb564dcd603.vfs.cloud9.us-east-1.amazonaws.com"
  # Do not eager load code on boot.
  config.eager_load = false

  config.action_controller.include_all_helpers = true
  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
class Application < Rails::Application
	config.web_console.whitelisted_ips = '149.43.121.126'
end
config.hosts << "12ccf29cdd9749de99cac4926fa00f72.vfs.cloud9.us-east-1.amazonaws.com"
config.hosts << "7f7f4f6316964035902c1b2f808bb275.vfs.cloud9.us-east-1.amazonaws.com"
#config.hosts << "12ccf29cdd9749de99cac4926fa00f72.vfs.cloud9.us-east-1.amazonaws.com"
config.hosts << "47a0eeda79c64b6daeba89d9dc3b866f.vfs.cloud9.us-east-1.amazonaws.com"
config.hosts << "17c272f855094c918e7a27a67097114a.vfs.cloud9.us-east-1.amazonaws.com"
config.hosts << "43fff9b56af040dda374e57d7e0b7b77.vfs.cloud9.us-east-1.amazonaws.com"

end
