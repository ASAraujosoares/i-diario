class FixRoundingTableIdForeignKeyOnExamRules < ActiveRecord::Migration[5.2]
  def change
    # 1. Safe remove
    begin
      remove_foreign_key :exam_rules, column: :rounding_table_id
    rescue ArgumentError, ActiveRecord::StatementInvalid
      # Ignore if it doesn't exist
    end

    # 2. Safe add using RAW SQL SAVEPOINT
    # Bypassing Ruby transaction helper entirely to avoid ArgumentError
    begin
      execute "SAVEPOINT safe_add_fk_savepoint"
      add_foreign_key :exam_rules, :rounding_tables
      execute "RELEASE SAVEPOINT safe_add_fk_savepoint"
    rescue ActiveRecord::StatementInvalid => e
      # Rollback to savepoint if error occurs
      execute "ROLLBACK TO SAVEPOINT safe_add_fk_savepoint"

      # Re-raise unless it is the "already exists" error
      is_duplicate = e.message.include?("already exists") || e.message.include?("PG::DuplicateObject")
      raise e unless is_duplicate
    end
  end
end
