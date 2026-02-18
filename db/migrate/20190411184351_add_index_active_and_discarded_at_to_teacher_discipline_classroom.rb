class AddIndexActiveAndDiscardedAtToTeacherDisciplineClassroom < ActiveRecord::Migration[5.2]
  def change
    add_index :teacher_discipline_classrooms, [:active, :discarded_at]
  end
end
