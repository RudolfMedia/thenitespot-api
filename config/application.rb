require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ThenitespotApi
  class Application < Rails::Application
    config.middleware.use Rack::Session::Cookie
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths += %w( #{config.root}/app/uploaders )
    config.autoload_paths += %w( #{config.root}/app/exceptions )
    
    env_file = Rails.root.join("config", 'local_env.yml').to_s
    YAML.load_file(env_file)[Rails.env].each do |key, value|
      ENV[key.to_s] = value
    end if File.exists?(env_file)

    config.assets.initialize_on_precompile = false
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'
    # config.active_record.default_timezone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.middleware.insert_before 0, "Rack::Cors", :debug => true, :logger => (-> { Rails.logger }) do
      allow do
        origins ENV['CORS_ORIGINS']

        resource '*',
          :headers => :any,
          :methods => [:get, :post, :delete, :put, :options, :head],
          :max_age => 0,
          :expose  => ['access-token', 'expiry', 'uid', 'client']

      end
    end
   config.middleware.use  Rack::Timeout
   config.middleware.insert_before(Rack::Timeout, 'TimeoutRecovery')

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.action_dispatch.perform_deep_munge = false

    config.to_prepare do
      Devise::Mailer.layout "mailer" 
    end
    
  end
end
