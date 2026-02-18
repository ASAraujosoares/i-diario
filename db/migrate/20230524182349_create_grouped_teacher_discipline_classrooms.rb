class CreateGroupedTeacherDisciplineClassrooms < ActiveRecord::Migration[5.2]
  def change
    create_view :grouped_teacher_discipline_classrooms
  end
end
