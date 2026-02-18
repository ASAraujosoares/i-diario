class AddDiscardedAtToDailyNoteStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_note_students, :discarded_at, :datetime
  end
end
