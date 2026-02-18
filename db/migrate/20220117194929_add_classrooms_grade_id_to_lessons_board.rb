class AddClassroomsGradeIdToLessonsBoard < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons_boards, :classrooms_grade_id, :integer
  end
end
