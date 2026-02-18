ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# FIX: Force YAML to be permissive (Psych 4/Ruby 3.2 compatibility for Rails 5.2)
# We patch this here in boot.rb to ensure it applies BEFORE Rails attempts to load database.yml
require 'yaml'
module YAML
  class << self
    alias_method :load, :unsafe_load if respond_to?(:unsafe_load)
  end
end

require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
