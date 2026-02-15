require 'digest'

# Fix for:
# 1. ArgumentError: wrong number of arguments (given 3, expected 2) in add_index_options (Ruby 3 vs Rails 5.2)
# 2. ArgumentError: Index name '...' is too long; the limit is 63 characters (PostgreSQL limit)

# Force load AbstractAdapter to ensure the module is available
begin
  require 'active_record/connection_adapters/abstract_adapter'
rescue LoadError
end

module AddIndexOptionsArityFix
  def add_index_options(table_name, column_name, *args, **kwargs)
    # 1. ARITY FIX: Handle legacy positional arguments (options hash as 3rd arg)
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # 2. LENGTH FIX: Check and auto-shorten index name if needed
    # Calculate what the name WOULD be
    index_name, index_type, index_columns, index_options, index_algorithm, index_using, comment = super(table_name, column_name, **kwargs)

    # If the generated name (or provided name) is too long for Postgres (63 chars)
    if index_name.to_s.length > 63
      # Create a deterministic short name using a hash of the original long name
      # "idx_" (4) + 10 chars of table name + "_" (1) + 10 chars of hash = 25 chars (safe)
      # We use a shorter hash to keep it readable but unique enough for migration contexts
      short_hash = Digest::SHA1.hexdigest(index_name.to_s)[0, 10]
      short_prefix = table_name.to_s[0, 15] # 15 chars of table name
      new_safe_name = "idx_#{short_prefix}_#{short_hash}"

      # Override the name in the original options
      kwargs[:name] = new_safe_name

      # Re-run super with the new safe name to get the correct return values
      return super(table_name, column_name, **kwargs)
    end

    # Return original result if length was fine
    return index_name, index_type, index_columns, index_options, index_algorithm, index_using, comment
  end
end

# Apply the patch
if defined?(ActiveRecord::ConnectionAdapters::AbstractAdapter)
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddIndexOptionsArityFix)
else
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(AddIndexOptionsArityFix)
  end
end
