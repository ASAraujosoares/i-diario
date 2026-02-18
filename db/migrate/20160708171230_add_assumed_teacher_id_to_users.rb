class AddAssumedTeacherIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :assumed_teacher_id, :integer
  end
end
