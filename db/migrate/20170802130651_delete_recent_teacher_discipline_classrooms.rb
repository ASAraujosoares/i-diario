class DeleteRecentTeacherDisciplineClassrooms < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      DELETE
        FROM teacher_discipline_classrooms
       WHERE year = 2017;
    SQL
  end
end
