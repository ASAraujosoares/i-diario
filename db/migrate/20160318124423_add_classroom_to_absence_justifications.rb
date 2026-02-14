class AddClassroomToAbsenceJustifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :absence_justifications, :classroom, index: true, foreign_key: true
  end
end
