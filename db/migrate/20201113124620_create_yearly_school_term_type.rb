class CreateYearlySchoolTermType < ActiveRecord::Migration[5.2]
  def change
    # We use execute with explicit timestamps to avoid NotNullViolation
    execute <<-SQL
      INSERT INTO school_term_types (description, steps_number, created_at, updated_at)
      VALUES ('Anual', 1, NOW(), NOW());
    SQL
  end
end
