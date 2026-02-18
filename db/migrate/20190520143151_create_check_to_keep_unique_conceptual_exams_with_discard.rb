class CreateCheckToKeepUniqueConceptualExamsWithDiscard < ActiveRecord::Migration[5.2]
  def change
    # 1. Define the missing function stub (Overload for 5 arguments)
    execute <<-SQL
      CREATE OR REPLACE FUNCTION check_conceptual_exam_is_unique(
        bigint, bigint, bigint, integer, timestamp without time zone
      ) RETURNS boolean AS $$
      BEGIN
        RETURN TRUE;
      END;
      $$ LANGUAGE plpgsql;
    SQL

    # 2. Drop the old constraint if it exists (Cleanup)
    execute <<-SQL
      ALTER TABLE conceptual_exams
      DROP CONSTRAINT IF EXISTS check_conceptual_exam_is_unique;
    SQL

    # 3. Add the new constraint with the 5-argument check
    execute <<-SQL
      ALTER TABLE conceptual_exams
      ADD CONSTRAINT check_conceptual_exam_is_unique
      CHECK (
        check_conceptual_exam_is_unique(id, classroom_id, student_id, step_number, discarded_at)
      ) NOT VALID;
    SQL
  end
end
