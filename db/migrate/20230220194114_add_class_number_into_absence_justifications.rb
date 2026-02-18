class AddClassNumberIntoAbsenceJustifications < ActiveRecord::Migration[5.2]
  def change
    add_column :absence_justifications, :class_number, :integer, null: true
  end
end
