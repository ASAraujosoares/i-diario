# config/initializers/14_fix_add_reference_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 3, expected 2) in add_reference
# Intercepts legacy calls passing options as a 3rd positional argument.

# Force load AbstractAdapter
begin
  require 'active_record/connection_adapters/abstract_adapter'
rescue LoadError
end

module AddReferenceArityFix
  def add_reference(table_name, ref_name, *args, **kwargs)
    # Ruby 3 Fix: If a 3rd positional argument exists (legacy options hash),
    # merge it into kwargs.
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original with strict signature (table_name, ref_name, **kwargs)
    super(table_name, ref_name, *args, **kwargs)
  end
end

# Apply immediately
if defined?(ActiveRecord::ConnectionAdapters::AbstractAdapter)
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddReferenceArityFix)
else
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddReferenceArityFix)
  end
end
