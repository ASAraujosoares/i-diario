# config/initializers/05_fix_transaction_class_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 3, expected 2) in Transaction#initialize
# Force load the file to ensure we can patch it.
begin
  require 'active_record/connection_adapters/abstract/transaction'
rescue LoadError
  # Should not happen in a standard Rails env
end

module TransactionInitializeFix
  # We change the signature to accept *args, swallowing the legacy positional argument
  def initialize(connection, options, *args, **kwargs)
    # Logic: If a 3rd positional argument is passed, it's the legacy run_commit_callbacks.
    # We move it to keywords.
    if !args.empty?
      legacy_arg = args.shift
      if legacy_arg.is_a?(Hash)
        kwargs = kwargs.merge(legacy_arg.symbolize_keys)
      elsif legacy_arg == true || legacy_arg == false
        kwargs[:run_commit_callbacks] = legacy_arg
      end
    end

    # Call original Rails 5.2 method with strict signature (connection, options, **kwargs)
    super(connection, options, **kwargs)
  end
end

# Apply immediately to the Transaction class
if defined?(ActiveRecord::ConnectionAdapters::Transaction)
  ActiveRecord::ConnectionAdapters::Transaction.prepend(TransactionInitializeFix)
end
