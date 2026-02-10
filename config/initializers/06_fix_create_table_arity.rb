# config/initializers/06_fix_create_table_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 2, expected 1) in create_table
# Intercepts legacy calls passing options as a 2nd positional argument.

# Ensure AbstractAdapter is loaded
begin
  require 'active_record/connection_adapters/abstract_adapter'
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

# Apply immediately
if defined?(ActiveRecord::ConnectionAdapters::AbstractAdapter)
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(CreateTableArityFix)
else
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(CreateTableArityFix)
  end
end
