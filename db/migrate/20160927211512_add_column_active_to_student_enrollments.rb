class AddColumnActiveToStudentEnrollments < ActiveRecord::Migration[5.2]
  def change
    add_column :student_enrollments, :active, :integer
  end
end
