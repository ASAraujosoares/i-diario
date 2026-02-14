class AddIdToAbsenceJustificationsDiscipline < ActiveRecord::Migration[5.2]
  def change
    add_column :absence_justifications_disciplines, :id, :primary_key
  end
end
