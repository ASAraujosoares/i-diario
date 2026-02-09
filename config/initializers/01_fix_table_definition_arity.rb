# Fix for ArgumentError: wrong number of arguments (given 5, expected 1..4)
# Legacy gems may pass a 5th positional argument (likely 'comment') which Rails 5.2 rejects.

ActiveSupport.on_load(:active_record) do
  module TableDefinitionArityFix
    # CORRECTED SIGNATURE: *args must appear BEFORE comment: nil
    def initialize(name, temporary = false, options = nil, as = nil, *args, comment: nil, **kwargs)

      # Logic: If a 5th positional argument exists (captured in *args), treat it as the comment.
      if args.any? && comment.nil?
        comment = args.first
      end

      # Call Rails 5.2 original initialize with named arguments
      super(name, temporary, options, as, comment: comment)
    end
  end

  ActiveRecord::ConnectionAdapters::TableDefinition.prepend(TableDefinitionArityFix)
end
