class CreateUnaccentExtension < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      CREATE EXTENSION unaccent;
    SQL
  end
end
