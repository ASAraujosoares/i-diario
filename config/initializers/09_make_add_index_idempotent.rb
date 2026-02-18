# config/initializers/09_make_add_index_idempotent.rb

# Fix for: ArgumentError: Index name '...' on table '...' already exists
# Makes add_index idempotent by skipping if the index exists.

# Force load AbstractAdapter
begin
  require 'active_record/connection_adapters/abstract_adapter'
rescue LoadError
end

module AddIndexIdempotency
  def add_index(table_name, column_name, options = {})
    # Check if index exists before trying to create it
    if index_exists?(table_name, column_name, options)
      puts "WARNING: Index on '#{table_name}' column '#{column_name}' already exists. Skipping add_index."
      return
    end

    # Check if an index with the explicit name exists (edge case)
    if options.is_a?(Hash) && options[:name] && index_name_exists?(table_name, options[:name], false)
       puts "WARNING: Index named '#{options[:name]}' on '#{table_name}' already exists. Skipping add_index."
       return
    end

    super
  end
end

# Apply the patch
if defined?(ActiveRecord::ConnectionAdapters::AbstractAdapter)
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddIndexIdempotency)
else
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddIndexIdempotency)
  end
end
