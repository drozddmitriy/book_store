Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = Uglifier.new(harmony: true)
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.serve_static_assets = true
  config.assets.compile = true
  config.assets.initialize_on_precompile = false

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :google
  config.log_level = :debug
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "bookstore_#{Rails.env}"

  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.action_mailer.default_url_options = { host: 'stormy-cove-64868.herokuapp.com', :protocol => 'https'  }
  config.action_mailer.delivery_method=:smtp
  config.action_mailer.raise_delivery_errors = true
  config.active_job.queue_adapter = :sidekiq
  config.cache_store = :redis_cache_store, { driver: :hiredis, url: ENV.fetch('REDIS_URL') }

  ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: ENV['MAIL_HOST'],
    user_name: ENV['GMAIL_USERNAME'],
    password: ENV['GMAIL_PASSWORD'],
    authentication: :plain,
    enable_starttls_auto: true
  }
end
