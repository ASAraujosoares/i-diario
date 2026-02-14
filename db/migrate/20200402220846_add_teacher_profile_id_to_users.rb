class AddTeacherProfileIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :teacher_profile_id, :integer
    add_foreign_key :users, :teacher_profiles
  end
end
