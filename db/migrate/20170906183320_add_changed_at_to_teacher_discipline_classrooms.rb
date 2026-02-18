class AddChangedAtToTeacherDisciplineClassrooms < ActiveRecord::Migration[5.2]
  def change
    add_column :teacher_discipline_classrooms, :changed_at, :string
  end
end
