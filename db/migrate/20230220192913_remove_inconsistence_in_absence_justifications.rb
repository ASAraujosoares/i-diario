class RemoveInconsistenceInAbsenceJustifications < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      delete from absence_justifications_students
      where not exists (
        select true from absence_justifications where id = absence_justification_id
      )
    SQL
  end
end
