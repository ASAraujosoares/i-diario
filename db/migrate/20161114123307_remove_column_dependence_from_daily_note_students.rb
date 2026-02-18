class RemoveColumnDependenceFromDailyNoteStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :daily_note_students, :dependence, :boolean
  end
end
