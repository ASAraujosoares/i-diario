# frozen_string_literal: true

require 'action_dispatch/middleware/static'

module ActionDispatch
  class Static
    # Patch for Ruby 3.0+ compatibility where ActionDispatch::MiddlewareStack passes options as a positional hash
    # but the original method expects keyword arguments.
    def initialize(app, path, *args, index: "index", headers: {})
      if args.first.is_a?(Hash)
        options = args.first
        index = options[:index] || index
        headers = options[:headers] || headers
      end

      @app = app
      @file_handler = FileHandler.new(path, index: index, headers: headers)
    end
  end
end
