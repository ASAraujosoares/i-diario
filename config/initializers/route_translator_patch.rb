# frozen_string_literal: true

# Patch RouteTranslator::Translator::Path::Segment to support Ruby 3 keyword arguments
# This is necessary because the installed version of route_translator (5.10.0) uses positional args for I18n.translate
# which breaks in Ruby 3.

if defined?(RouteTranslator)
  require 'route_translator/translator/path/segment'

  module RouteTranslator
    module Translator
      module Path
        module Segment
          class << self
            def translate_resource(str, locale, scope)
              handler = proc { |exception| exception }
              opts    = { locale: locale, scope: scope }

              # Use double-splat ** to pass options as keywords
              if I18n.translate(str, **opts.merge(exception_handler: handler)).is_a?(I18n::MissingTranslation)
                I18n.translate(str, **opts.merge(fallback_options(str, locale)))
              else
                I18n.translate(str, **opts)
              end
            end
          end
        end
      end
    end
  end
end
