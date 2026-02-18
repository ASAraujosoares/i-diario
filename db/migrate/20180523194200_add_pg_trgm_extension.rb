class AddPgTrgmExtension < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      CREATE EXTENSION pg_trgm;
    SQL
  end
end
