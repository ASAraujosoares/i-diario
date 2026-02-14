class AddUserIdToAbsenceJustifications < ActiveRecord::Migration[5.2]
  def change
    add_column :absence_justifications, :user_id, :integer
  end
end
