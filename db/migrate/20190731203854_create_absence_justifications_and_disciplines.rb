class CreateAbsenceJustificationsAndDisciplines < ActiveRecord::Migration[5.2]
  def change
    create_table :absence_justifications_disciplines, id: false do |t|
      t.belongs_to :discipline, null: true
      t.belongs_to :absence_justification, null: false
    end
  end
end
