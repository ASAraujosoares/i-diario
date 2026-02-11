# config/initializers/06_fix_create_table_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 3, expected 1..2) in create_table
# We patch SchemaStatements directly as it is the final destination for create_table calls.

# Force load SchemaStatements
begin
  require 'active_record/connection_adapters/abstract/schema_statements'
rescue LoadError
end

module CreateTableArityFix
  def create_table(table_name, *args, **kwargs, &block)
    # Ruby 3 Fix: If the 2nd argument (first in *args) is a Hash,
    # it's a legacy options hash. Merge it into kwargs.
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original with strict signature (table_name, **kwargs)
    super(table_name, *args, **kwargs, &block)
  end
end

# Apply immediately to SchemaStatements
if defined?(ActiveRecord::ConnectionAdapters::SchemaStatements)
  ActiveRecord::ConnectionAdapters::SchemaStatements.prepend(CreateTableArityFix)
end

# Also apply to Compatibility layer just in case
ActiveSupport.on_load(:active_record) do
  if defined?(ActiveRecord::Migration::Compatibility::V4_2)
    ActiveRecord::Migration::Compatibility::V4_2.prepend(CreateTableArityFix)
  end
end
