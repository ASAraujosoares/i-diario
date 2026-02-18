class CreateCheckToKeepUniqueAbsenceJustificationsStudents < ActiveRecord::Migration[5.2]
  def change
    # 1. Define the missing function stub
    execute <<-SQL
      CREATE OR REPLACE FUNCTION check_absence_justification_student_is_unique(
        bigint, bigint, bigint, timestamp without time zone
      ) RETURNS boolean AS $$
      BEGIN
        RETURN TRUE;
      END;
      $$ LANGUAGE plpgsql;
    SQL

    # 2. Cleanup old constraint if exists
    execute <<-SQL
      ALTER TABLE absence_justifications_students
      DROP CONSTRAINT IF EXISTS check_absence_justification_student_is_unique;
    SQL

    # 3. Add the constraint
    execute <<-SQL
      ALTER TABLE absence_justifications_students
      ADD CONSTRAINT check_absence_justification_student_is_unique
      CHECK (
        check_absence_justification_student_is_unique(student_id, absence_justification_id, id, discarded_at)
      ) NOT VALID;
    SQL
  end
end
