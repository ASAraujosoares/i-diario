require 'active_model/type'
require 'active_model/type/integer'
require 'active_model/type/value'

module Ruby3KeywordsShim
  def initialize(*args, **kwargs)
    # If the first argument is a Hash and we received no kwargs,
    # treat the hash as keywords (Legacy Ruby 2 style fix).
    if args.present? && args.first.is_a?(Hash) && kwargs.empty?
      kwargs = args.shift.symbolize_keys
    end
    super(*args, **kwargs)
  end
end

ActiveSupport.on_load(:active_model) do
  ActiveModel::Type::Value.prepend(Ruby3KeywordsShim)
  ActiveModel::Type::Integer.prepend(Ruby3KeywordsShim)
  # We patch Integer explicitly because it overrides initialize in Rails 5.2
end
