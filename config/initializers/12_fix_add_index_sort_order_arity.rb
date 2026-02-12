# config/initializers/12_fix_add_index_sort_order_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 2, expected 1) in add_index_sort_order
# Intercepts calls passing options as a 2nd positional argument.

# Force load AbstractAdapter
begin
  require 'active_record/connection_adapters/abstract_adapter'
rescue LoadError
end

module AddIndexSortOrderArityFix
  def add_index_sort_order(*args, **kwargs)
    # Ruby 3 Fix: If we received extra positional arguments and one is a Hash,
    # it's likely the legacy options.
    if args.size > 1 && args.last.is_a?(Hash)
      options = args.pop
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original. We assume the method signature expects (arg1, **kwargs)
    # based on the "expected 1" error message.
    super(*args, **kwargs)
  end
end

# Apply immediately
if defined?(ActiveRecord::ConnectionAdapters::AbstractAdapter)
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddIndexSortOrderArityFix)
else
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddIndexSortOrderArityFix)
  end
end
