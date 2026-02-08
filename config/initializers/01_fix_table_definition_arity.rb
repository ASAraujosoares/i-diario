# Fix for ArgumentError: wrong number of arguments (given 5, expected 1..4)
# Legacy gems may pass a 5th positional argument (likely 'comment') which Rails 5.2 rejects.

ActiveSupport.on_load(:active_record) do
  module TableDefinitionArityFix
    def initialize(name, temporary = false, options = nil, as = nil, comment: nil, *args, **kwargs)
      # If a 5th positional argument exists (in *args), we assume it's the comment.
      # We assign it to the 'comment' keyword if not already set.
      if args.any? && comment.nil?
        comment = args.first
      end

      # Call original initialize with strictly the arguments it expects (4 positional + keywords)
      # We drop any remaining *args to prevent the error.
      super(name, temporary, options, as, comment: comment)
    end
  end

  ActiveRecord::ConnectionAdapters::TableDefinition.prepend(TableDefinitionArityFix)
end
