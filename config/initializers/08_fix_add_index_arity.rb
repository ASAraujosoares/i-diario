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

    # 2. LENGTH FIX (Pre-emptive): Check length BEFORE calling super to avoid validation crash
    # Construct the name that Rails would likely generate if not provided
    if kwargs[:name]
      candidate_name = kwargs[:name].to_s
    else
      # Rails default: index_table_on_col1_and_col2...
      # Note: This is an approximation of what Rails does, but sufficient for length checking.
      # If Rails generates a different name, it will likely be similar in length.
      # The safest bet for VERY long inferred names is to force a name anyway if we suspect overflow.

      # However, we only care if the *provided* name or the *very likely* name is too long.
      # Calculating the exact Rails default name here is complex (handling scope/lengths).
      # BUT, if we generate a name based on table+columns and it's long, we should override it.

      cols = Array(column_name).map(&:to_s).join('_and_')
      candidate_name = "index_#{table_name}_on_#{cols}"
    end

    # If it exceeds Postgres limit (63 chars), force a short deterministic hash name
    if candidate_name.length > 63
      short_hash = Digest::SHA1.hexdigest(candidate_name)[0, 40]
      # Pattern: idx_ + first 10 chars of table + _ + 40 chars hash = 55 chars (Safe)
      short_prefix = table_name.to_s[0, 10]
      new_safe_name = "idx_#{short_prefix}_#{short_hash}"

      # Inject the safe name into options so Rails accepts it without complaining
      kwargs[:name] = new_safe_name
    end

    # Call original method with the now-safe arguments
    super(table_name, column_name, *args, **kwargs)
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
