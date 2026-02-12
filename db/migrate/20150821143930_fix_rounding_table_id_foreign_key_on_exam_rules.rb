class FixRoundingTableIdForeignKeyOnExamRules < ActiveRecord::Migration[4.2]
  def change
    # 1. Attempt to remove the old FK safely
    begin
      remove_foreign_key :exam_rules, column: :rounding_table_id
    rescue ArgumentError, ActiveRecord::StatementInvalid
      # Ignore if it doesn't exist or is invalid
    end

    # 2. Attempt to add the new FK safely
    begin
      add_foreign_key :exam_rules, :rounding_tables
    rescue ActiveRecord::StatementInvalid => e
      # Only ignore "already exists" errors (PG::DuplicateObject)
      raise e unless e.message.include?("already exists") || e.message.include?("PG::DuplicateObject")
    end
  end
end
