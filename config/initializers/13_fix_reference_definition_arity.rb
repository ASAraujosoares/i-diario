# config/initializers/13_fix_reference_definition_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 2, expected 1) in ReferenceDefinition#initialize
# Intercepts legacy calls passing options as a 2nd positional argument.

# Force load SchemaDefinitions
begin
  require 'active_record/connection_adapters/abstract/schema_definitions'
rescue LoadError
end

module ReferenceDefinitionArityFix
  def initialize(name, *args, **kwargs)
    # Ruby 3 Fix: If a 2nd positional argument exists (legacy options hash),
    # merge it into kwargs.
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original with strict signature (name, **kwargs)
    super(name, *args, **kwargs)
  end
end

# Apply immediately
if defined?(ActiveRecord::ConnectionAdapters::ReferenceDefinition)
  ActiveRecord::ConnectionAdapters::ReferenceDefinition.prepend(ReferenceDefinitionArityFix)
else
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::ReferenceDefinition.prepend(ReferenceDefinitionArityFix)
  end
end
