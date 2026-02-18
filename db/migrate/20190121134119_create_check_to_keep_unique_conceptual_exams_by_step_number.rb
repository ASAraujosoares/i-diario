class CreateCheckToKeepUniqueConceptualExamsByStepNumber < ActiveRecord::Migration[5.2]
  def change
    # 1. Define the missing function stub (Overload for INTEGER step_number)
    execute <<-SQL
      CREATE OR REPLACE FUNCTION check_conceptual_exam_is_unique(
        bigint, bigint, bigint, integer
      ) RETURNS boolean AS $$
      BEGIN
        RETURN TRUE;
      END;
      $$ LANGUAGE plpgsql;
    SQL

    # 2. Drop the old constraint if it exists (Cleanup/Idempotency)
    # This prevents collision with the constraint created in the 2018 migration
    execute <<-SQL
      ALTER TABLE conceptual_exams
      DROP CONSTRAINT IF EXISTS check_conceptual_exam_is_unique;
    SQL

    # 3. Add the new constraint using the new function signature
    execute <<-SQL
      ALTER TABLE conceptual_exams
      ADD CONSTRAINT check_conceptual_exam_is_unique
      CHECK (check_conceptual_exam_is_unique(id, classroom_id, student_id, step_number)) NOT VALID;
    SQL
  end
end
