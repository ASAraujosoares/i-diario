require_relative 'boot'

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Patch ActiveRecord::Type delegation for Ruby 3 compatibility
require 'active_record/type'
module ActiveRecord
  module Type
    class << self
      def add_modifier(*args, **kwargs)
        registry.add_modifier(*args, **kwargs)
      end
    end
  end
end

# FIX: Force YAML to be permissive (Psych 4/Ruby 3.2 compatibility for Rails 5.2)
# This must run before any YAML loading happens in the app boot.
require 'yaml'
module YAML
  class << self
    alias_method :load, :unsafe_load if respond_to?(:unsafe_load)
  end
end

module Educacao
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.eager_load_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('app/workers')
    config.eager_load_paths << Rails.root.join('app/workers/ieducar')
    config.eager_load_paths << Rails.root.join('app/workers/concerns')
    config.eager_load_paths << Rails.root.join('app/workers/student_dependencies_discarders')
    config.eager_load_paths << Rails.root.join('app/services')
    config.eager_load_paths << Rails.root.join('app/services/ieducar_synchronizers')
    config.eager_load_paths << Rails.root.join('app/queries')

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.load_path += Dir["#{config.root}/config/locales/**/*.yml"]
    config.i18n.default_locale = :"pt-BR"

    config.active_record.schema_format = :sql

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
      end
    end
  end
end
