class FixRoundingTableIdForeignKeyOnExamRules < ActiveRecord::Migration[4.2]
  def change
    # 1. Safe remove (Ruby rescue works fine for logic errors)
    begin
      remove_foreign_key :exam_rules, column: :rounding_table_id
    rescue ArgumentError, ActiveRecord::StatementInvalid
      # Ignore if it doesn't exist
    end

    # 2. Safe add using RAW SQL SAVEPOINT
    # This bypasses the buggy 'transaction(requires_new: true)' Ruby helper
    # and speaks directly to Postgres to isolate the potential error.
    begin
      execute "SAVEPOINT safe_add_fk_savepoint"
      add_foreign_key :exam_rules, :rounding_tables
      execute "RELEASE SAVEPOINT safe_add_fk_savepoint"
    rescue ActiveRecord::StatementInvalid => e
      # If DB errors, roll back only to the savepoint so the migration doesn't crash
      execute "ROLLBACK TO SAVEPOINT safe_add_fk_savepoint"

      # Re-raise only if it's NOT the "already exists" error
      is_duplicate = e.message.include?("already exists") || e.message.include?("PG::DuplicateObject")
      raise e unless is_duplicate
    end
  end
end
