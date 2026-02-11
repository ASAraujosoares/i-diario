# config/initializers/08_fix_add_index_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 3, expected 2) in add_index_options
# Intercepts internal calls passing options as a 3rd positional argument.

# Force load AbstractAdapter to ensure we can patch the class directly
begin
  require 'active_record/connection_adapters/abstract_adapter'
rescue LoadError
end

module AddIndexOptionsArityFix
  def add_index_options(table_name, column_name, *args, **kwargs)
    # Ruby 3 Fix: If a 3rd positional argument exists (legacy options hash),
    # merge it into keywords.
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original with strict signature (table_name, column_name, **kwargs)
    super(table_name, column_name, *args, **kwargs)
  end
end

# Apply explicitly to the AbstractAdapter class (parent of PostgreSQLAdapter)
if defined?(ActiveRecord::ConnectionAdapters::AbstractAdapter)
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddIndexOptionsArityFix)
else
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddIndexOptionsArityFix)
  end
end
