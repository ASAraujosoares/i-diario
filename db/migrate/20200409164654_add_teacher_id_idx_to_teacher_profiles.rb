class AddTeacherIdIdxToTeacherProfiles < ActiveRecord::Migration[5.2]
  def change
    add_index :teacher_profiles, :teacher_id
  end
end
