class UpdateAllDailyNoteStudentsToActive < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      UPDATE daily_note_students set active = 't';
    SQL
  end
end
