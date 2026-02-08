require 'active_model/type'
require 'active_model/type/integer'
require 'active_model/type/value'

module Ruby3KeywordsShim
  def initialize(*args, **kwargs)
    # Ruby 3 Fix: If the first argument is a Hash and we received no kwargs,
    # assume it's a legacy options hash and convert it to keywords.
    if !args.empty? && args.first.is_a?(Hash) && kwargs.empty?
      options = args.shift
      kwargs = options.transform_keys(&:to_sym)
    end
    super(*args, **kwargs)
  end
end

# Apply immediately without waiting for :on_load hooks,
# as the class is likely already loaded by legacy gems.
if defined?(ActiveModel::Type::Value)
  ActiveModel::Type::Value.prepend(Ruby3KeywordsShim)
end

if defined?(ActiveModel::Type::Integer)
  ActiveModel::Type::Integer.prepend(Ruby3KeywordsShim)
end
