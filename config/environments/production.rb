Rails.application.configure do
  config.action_controller.perform_caching = true
  config.active_job.queue_adapter = :sidekiq
  config.action_mailer.asset_host = 'http://www.vpzven.ru'
  config.action_mailer.default_url_options = { host: 'www.vpzven.ru' }
  config.action_mailer.delivery_method = :test
  config.active_record.dump_schema_after_migration = false
  config.active_support.deprecation = :notify
  config.assets.compile = false
  config.assets.digest = true
  config.assets.js_compressor = Uglifier.new(mangle: false)
  config.assets.precompile += %w( *.slim mail.css )
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.eager_load = true
  config.i18n.fallbacks = true
  config.log_formatter = ::Logger::Formatter.new
  config.log_level = :warn
  config.serve_static_files = false
end
