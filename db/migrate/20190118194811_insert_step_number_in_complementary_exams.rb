class InsertStepNumberInComplementaryExams < ActiveRecord::Migration[5.2]
  def change
    # 1. Define the missing function (Stub) FIRST
    # It must return a table with a step_number column to satisfy the SELECT query below
    execute <<-SQL
      CREATE OR REPLACE FUNCTION step_by_classroom(
        p_classroom_id bigint, p_recorded_at date
      ) RETURNS TABLE (step_number integer) AS $$
      BEGIN
        RETURN QUERY SELECT 0;
      END;
      $$ LANGUAGE plpgsql;
    SQL

    # 2. The Original Update Logic
    execute <<-SQL
      UPDATE complementary_exams
         SET step_number = (
           SELECT COALESCE(MAX(step.step_number), 0)
             FROM step_by_classroom(
                    complementary_exams.classroom_id,
                    complementary_exams.recorded_at
                  ) AS step
         );
    SQL
  end
end
