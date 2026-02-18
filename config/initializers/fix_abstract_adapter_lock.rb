require 'monitor'
require 'active_record/connection_adapters/abstract_adapter'

module EnsureAbstractAdapterLock
  def initialize(*args)
    super
    # Safety net: Ensure @lock exists if the original initialize failed to set it
    @lock ||= Monitor.new
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(EnsureAbstractAdapterLock)
end
