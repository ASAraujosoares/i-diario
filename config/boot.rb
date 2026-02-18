# FIX: Force YAML to be permissive (Psych 4/Ruby 3.2 compatibility for Rails 5.2)
# This must be the first thing to run.
require 'yaml'
module YAML
  class << self
    alias_method :load, :unsafe_load if respond_to?(:unsafe_load)
  end
end

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Bootsnap REMOVED to prevent caching interference.
# require 'bootsnap/setup'
