class AddStatusToStudentEnrollments < ActiveRecord::Migration[5.2]
  def change
    add_column :student_enrollments, :status, :integer
  end
end
