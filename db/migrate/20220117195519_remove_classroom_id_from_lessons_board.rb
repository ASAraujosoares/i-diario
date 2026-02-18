class RemoveClassroomIdFromLessonsBoard < ActiveRecord::Migration[5.2]
  def change
    remove_column :lessons_boards, :classroom_id
  end
end
