# config/initializers/13_fix_reference_definition_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 2, expected 1) in ReferenceDefinition#initialize

# 1. Force Load the file defining ReferenceDefinition
begin
  require 'active_record/connection_adapters/abstract/schema_definitions'
rescue LoadError
end

# 2. Define the shim module
module ReferenceDefinitionArityFix
  def initialize(name, *args, **kwargs)
    # Ruby 3 Fix: If we receive a positional Hash (legacy options), treat it as keywords
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end
    super(name, *args, **kwargs)
  end
end

# 3. Apply to ReferenceDefinition Class
if defined?(ActiveRecord::ConnectionAdapters::ReferenceDefinition)
  ActiveRecord::ConnectionAdapters::ReferenceDefinition.prepend(ReferenceDefinitionArityFix)
end

# 4. CRITICAL: Also patch TableDefinition directly, as it may have already included the broken method
# This fixes the `t.references` caller side as a fallback
module TableDefinitionReferencesFix
  def references(*args)
    options = args.extract_options!
    args.each do |ref_name|
      # Explicitly use **options to force keyword argument passing
      ActiveRecord::ConnectionAdapters::ReferenceDefinition.new(ref_name, **options).add_to(self)
    end
  end
  alias :belongs_to :references
end

if defined?(ActiveRecord::ConnectionAdapters::TableDefinition)
  ActiveRecord::ConnectionAdapters::TableDefinition.prepend(TableDefinitionReferencesFix)
end
