class FixRoundingTableIdForeignKeyOnExamRules < ActiveRecord::Migration[4.2]
  def change
    # 1. Safe remove (ArgumentError is Ruby-level, so standard rescue works fine)
    begin
      remove_foreign_key :exam_rules, column: :rounding_table_id
    rescue ArgumentError
      # Key didn't exist in Rails cache/definition
    rescue ActiveRecord::StatementInvalid
      # Key didn't exist in DB
    end

    # 2. Safe add using SAVEPOINT (Crucial for Postgres)
    # We wrap this in a sub-transaction. If it fails, it rolls back ONLY this block,
    # leaving the main transaction alive.
    begin
      transaction(requires_new: true) do
        add_foreign_key :exam_rules, :rounding_tables
      end
    rescue ActiveRecord::StatementInvalid => e
      # Now we can safely ignore the error because the DB transaction was restored
      raise e unless e.message.include?("already exists") || e.message.include?("PG::DuplicateObject")
    end
  end
end
