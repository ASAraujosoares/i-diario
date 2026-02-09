# config/initializers/04_fix_transaction_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 1, expected 0) in transaction
# Intercepts legacy calls passing 'options' as a positional Hash to transaction().

ActiveSupport.on_load(:active_record) do
  module TransactionArityFix
    def transaction(*args, **kwargs, &block)
      # Ruby 3 Fix: If we receive a positional Hash (legacy options) and no keywords,
      # convert the Hash to keywords.
      if args.present? && args.first.is_a?(Hash) && kwargs.empty?
        options = args.shift
        kwargs = kwargs.merge(options.symbolize_keys)
      end

      # Pass correct arguments (keywords) to the original Rails method
      super(*args, **kwargs, &block)
    end
  end

  # Prepend to DatabaseStatements because that is where 'transaction' is defined,
  # and legacy adapters call 'super' which bubbles up to this module.
  ActiveRecord::ConnectionAdapters::DatabaseStatements.prepend(TransactionArityFix)
end
