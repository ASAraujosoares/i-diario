class AddUnityToAbsenceJustifications < ActiveRecord::Migration[5.2]
  def change
    add_reference :absence_justifications, :unity, index: true, foreign_key: true
  end
end
