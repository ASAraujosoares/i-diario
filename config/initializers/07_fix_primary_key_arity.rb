# config/initializers/07_fix_primary_key_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 3, expected 1..2) in primary_key
# Intercepts internal Rails calls passing options as a 3rd positional argument.

# Force load PostgreSQL Schema Definitions
begin
  require 'active_record/connection_adapters/postgresql/schema_definitions'
rescue LoadError
end

module PrimaryKeyArityFix
  def primary_key(name, type = :primary_key, *args, **kwargs)
    # Ruby 3 Fix: If a 3rd positional argument exists (legacy options hash),
    # merge it into keywords.
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original with strict signature (name, type, **kwargs)
    super(name, type, *args, **kwargs)
  end
end

# Apply to PostgreSQL TableDefinition
ActiveSupport.on_load(:active_record) do
  if defined?(ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition)
    ActiveRecord::ConnectionAdapters::PostgreSQL::TableDefinition.prepend(PrimaryKeyArityFix)
  end
end
