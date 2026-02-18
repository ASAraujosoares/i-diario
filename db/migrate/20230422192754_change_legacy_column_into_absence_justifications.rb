class ChangeLegacyColumnIntoAbsenceJustifications < ActiveRecord::Migration[5.2]
  def change
    change_column :absence_justifications, :legacy, :boolean, default: false
  end
end
