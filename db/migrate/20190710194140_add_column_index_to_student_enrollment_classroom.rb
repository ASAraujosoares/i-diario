class AddColumnIndexToStudentEnrollmentClassroom < ActiveRecord::Migration[5.2]
  def change
    add_column :student_enrollment_classrooms, :index, :integer
  end
end
