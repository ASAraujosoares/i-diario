class AddForeignKeyCurrentClassroomIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :users, :classrooms, column: :current_classroom_id
  end
end
