# Fix for Psych::DisallowedClass in Ruby 3.2+
# Allows YAML loading of standard Rails time/date classes
if Rails.application.config.respond_to?(:active_record)
  Rails.application.config.active_record.yaml_column_permitted_classes = [
    Symbol, Date, Time, ActiveSupport::TimeWithZone, ActiveSupport::TimeZone
  ]
end
