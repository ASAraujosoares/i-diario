class DefineJustificationAsNull < ActiveRecord::Migration[5.2]
  def change
    change_column :absence_justifications, :justification, :text, null: true
  end
end
