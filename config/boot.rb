# FIX: Force YAML to be permissive (Psych 4 compatibility for Rails 5.2)
# Must be first!
require 'yaml'
module YAML
  class << self
    alias_method :load, :unsafe_load if respond_to?(:unsafe_load)
  end
end

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Disable bootsnap to prevent caching issues with YAML loading
# require 'bootsnap/setup'
