class RemoveForeignKeysOnConceptualExams < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      DROP INDEX unique_index_on_conceptual_exams;
    SQL
  end
end
