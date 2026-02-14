class AddColumnSpecificAreaToTeacherDisciplineClassroom < ActiveRecord::Migration[5.2]
  def change
    add_column :teacher_discipline_classrooms, :specific_area, :integer
  end
end
