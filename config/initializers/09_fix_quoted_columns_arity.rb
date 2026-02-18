# config/initializers/09_fix_quoted_columns_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 2, expected 1) in quoted_columns_for_index
# Intercepts internal calls passing options as a 2nd positional argument.

# Force load AbstractAdapter
begin
  require 'active_record/connection_adapters/abstract_adapter'
rescue LoadError
end

module QuotedColumnsArityFix
  def quoted_columns_for_index(column_names, *args, **kwargs)
    # Ruby 3 Fix: If a 2nd positional argument exists (legacy options hash),
    # merge it into kwargs.
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original with strict signature (column_names, **kwargs)
    super(column_names, *args, **kwargs)
  end
end

# Apply immediately
if defined?(ActiveRecord::ConnectionAdapters::AbstractAdapter)
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(QuotedColumnsArityFix)
else
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(QuotedColumnsArityFix)
  end
end
