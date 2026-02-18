# FIX: Patch ActiveRecord::Migrator for DatabaseCleaner compatibility with Rails 5.2+
# Old versions of DatabaseCleaner look for this method which was removed in Rails 5.0
require 'active_record/migration'

class ActiveRecord::Migrator
  def self.schema_migrations_table_name
    ActiveRecord::SchemaMigration.table_name
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    # Clean the database at the start, preserving the migration table
    DatabaseCleaner.clean_with(:truncation, except: %w[public.schema_migrations])
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
