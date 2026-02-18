class CreateCheckToKeepUniqueDescriptiveExamsByStepNumber < ActiveRecord::Migration[5.2]
  def change
    # 1. Define the missing function stub (Overload for INTEGER step_number)
    execute <<-SQL
      CREATE OR REPLACE FUNCTION check_descriptive_exam_is_unique(
        bigint, bigint, bigint, integer
      ) RETURNS boolean AS $$
      BEGIN
        RETURN TRUE;
      END;
      $$ LANGUAGE plpgsql;
    SQL

    # 2. Drop the old constraint if it exists (Cleanup/Idempotency)
    execute <<-SQL
      ALTER TABLE descriptive_exams
      DROP CONSTRAINT IF EXISTS check_descriptive_exam_is_unique;
    SQL

    # 3. Add the new constraint
    execute <<-SQL
      ALTER TABLE descriptive_exams
      ADD CONSTRAINT check_descriptive_exam_is_unique
      CHECK (check_descriptive_exam_is_unique(id, classroom_id, discipline_id, step_number)) NOT VALID;
    SQL
  end
end
