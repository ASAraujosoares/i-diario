# config/initializers/03_fix_type_to_sql_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 2, expected 1) in type_to_sql
# Intercepts legacy calls passing a generic options Hash as the 2nd argument.

# Force load the PostgreSQL adapter definition so we can patch it reliably
begin
  require 'active_record/connection_adapters/postgresql_adapter'
rescue LoadError
  # If we are not using PG, this might fail, but we are in a PG environment.
end

module TypeToSqlArityFix
  def type_to_sql(type, *args, **kwargs)
    # Ruby 3 Fix: If the 2nd argument (first in *args) is a Hash,
    # it's a legacy options hash. Merge it into kwargs.
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original with strict signature (type, **kwargs)
    super(type, *args, **kwargs)
  end
end

# Apply immediately if the class exists
if defined?(ActiveRecord::ConnectionAdapters::PostgreSQLAdapter)
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(TypeToSqlArityFix)
else
  # Fallback to on_load if not defined yet (safety net)
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(TypeToSqlArityFix)
  end
end
