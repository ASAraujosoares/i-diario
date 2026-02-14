class AddForeignKeyIntoAbsenceJustificationsStudents < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :absence_justifications_students, :absence_justifications, foreign_key: true
  end
end
