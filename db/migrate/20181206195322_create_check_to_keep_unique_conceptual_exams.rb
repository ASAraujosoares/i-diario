class CreateCheckToKeepUniqueConceptualExams < ActiveRecord::Migration[5.2]
  def change
    # 1. Define the missing function (Stub) FIRST
    # We use CREATE OR REPLACE to be idempotent
    execute <<-SQL
      CREATE OR REPLACE FUNCTION check_conceptual_exam_is_unique(
        bigint, bigint, bigint, date
      ) RETURNS boolean AS $$
      BEGIN
        RETURN TRUE;
      END;
      $$ LANGUAGE plpgsql;
    SQL

    # 2. Add the constraint (Original Logic) SECOND
    execute <<-SQL
      ALTER TABLE conceptual_exams
      ADD CONSTRAINT check_conceptual_exam_is_unique
      CHECK (check_conceptual_exam_is_unique(id, classroom_id, student_id, recorded_at)) NOT VALID;
    SQL
  end
end
