class RemoveGradeIdFromClassrooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :classrooms, :grade_id
  end
end
