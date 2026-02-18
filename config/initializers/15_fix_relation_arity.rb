# config/initializers/15_fix_relation_arity.rb

# Fix for ArgumentError: wrong number of arguments (given 2, expected 1) in ActiveRecord::Relation#initialize
# Intercepts legacy calls passing values/options as a 2nd positional argument.

# Force load Relation
begin
  require 'active_record/relation'
rescue LoadError
end

module RelationArityFix
  def initialize(klass, *args, **kwargs)
    # Ruby 3 Fix: If a 2nd positional argument exists (legacy options hash),
    # merge it into keywords.
    if !args.empty? && args.first.is_a?(Hash)
      options = args.shift
      kwargs = kwargs.merge(options.symbolize_keys)
    end

    # Call original with strict signature (klass, **kwargs)
    super(klass, *args, **kwargs)
  end
end

# Apply immediately
if defined?(ActiveRecord::Relation)
  ActiveRecord::Relation.prepend(RelationArityFix)
end
