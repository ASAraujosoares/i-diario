class AddLegacyColumnIntoAbsenceJustifications < ActiveRecord::Migration[5.2]
  def change
    add_column :absence_justifications, :legacy, :boolean, default: false
  end
end
