# config/initializers/11_fix_pg_add_index_opclass_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 2, expected 1) in add_index_opclass
# Intercepts internal calls passing options as a 2nd positional argument.

# Force load PostgreSQL Adapter
begin
  require 'active_record/connection_adapters/postgresql_adapter'
rescue LoadError
end

module PGAddIndexOpclassArityFix
  def add_index_opclass(quoted_columns, *args, **kwargs)
    # Ruby 3 Fix: If a 2nd positional argument exists (legacy options hash),
    # merge it into kwargs.
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original with strict signature (quoted_columns, **kwargs)
    super(quoted_columns, *args, **kwargs)
  end
end

# Apply immediately to PostgreSQLAdapter
if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter)
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(PGAddIndexOpclassArityFix)
else
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(PGAddIndexOpclassArityFix)
  end
end
