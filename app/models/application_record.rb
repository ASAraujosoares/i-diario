class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.has_no_table
    # Shim to replace activerecord-tablefree gem functionality

    # Define columns attribute if it doesn't exist (ActiveRecord usually defines it, but we override)
    define_singleton_method :columns do
      []
    end

    define_singleton_method :columns_hash do
      {}
    end

    # Ensure it doesn't try to query a table
    define_singleton_method :table_exists? do
      false
    end

    # Override connection to use the base connection (avoiding table lookups)
    define_singleton_method :connection do
      ActiveRecord::Base.connection
    end
  end
end
