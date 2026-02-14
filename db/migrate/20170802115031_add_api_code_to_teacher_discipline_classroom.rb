class AddApiCodeToTeacherDisciplineClassroom < ActiveRecord::Migration[5.2]
  def change
    add_column :teacher_discipline_classrooms, :api_code, :string
  end
end
