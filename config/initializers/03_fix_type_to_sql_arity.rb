# config/initializers/03_fix_type_to_sql_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 2, expected 1) in type_to_sql
# Intercepts legacy calls passing a generic options Hash as the 2nd argument.

ActiveSupport.on_load(:active_record) do
  module TypeToSqlArityFix
    def type_to_sql(type, *args, **kwargs)
      # Ruby 3 Fix: If the 2nd argument (first in *args) is a Hash,
      # it's a legacy options hash. Merge it into kwargs.
      if args.present? && args.first.is_a?(Hash)
        options = args.shift
        kwargs = kwargs.merge(options.symbolize_keys)
      end

      # Call original with strict signature (type, **kwargs)
      super(type, *args, **kwargs)
    end
  end

  # Apply to PostgreSQLAdapter specifically as indicated by the stack trace
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(TypeToSqlArityFix)
end
