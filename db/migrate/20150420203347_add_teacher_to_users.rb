class AddTeacherToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :teacher_id, :integer
    add_index :users, :teacher_id
    add_foreign_key :users, :teachers
  end
end
