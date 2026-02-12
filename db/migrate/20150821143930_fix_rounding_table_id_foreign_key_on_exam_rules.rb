class FixRoundingTableIdForeignKeyOnExamRules < ActiveRecord::Migration[4.2]
  def change
    if foreign_key_exists?(:exam_rules, column: :rounding_table_id)
      remove_foreign_key :exam_rules, column: :rounding_table_id
    end

    unless foreign_key_exists?(:exam_rules, :rounding_tables)
      add_foreign_key :exam_rules, :rounding_tables
    end
  end
end
