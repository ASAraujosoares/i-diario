# config/initializers/02_fix_column_definition_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 3, expected 2) in new_column_definition
# Intercepts legacy calls passing 'options' as a 3rd positional argument.

ActiveSupport.on_load(:active_record) do
  module ColumnDefinitionArityFix
    def new_column_definition(name, type, *args, **kwargs)
      # If there is a 3rd positional argument, it's the legacy 'options' hash.
      # We merge it into kwargs.
      if args.any? && args.first.is_a?(Hash)
        legacy_options = args.shift
        kwargs = kwargs.merge(legacy_options)
      end

      # Call original with strict signature (name, type, **kwargs)
      super(name, type, **kwargs)
    end
  end

  ActiveRecord::ConnectionAdapters::TableDefinition.prepend(ColumnDefinitionArityFix)
end
