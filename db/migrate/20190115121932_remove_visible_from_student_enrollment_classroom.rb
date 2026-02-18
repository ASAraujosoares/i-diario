class RemoveVisibleFromStudentEnrollmentClassroom < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_enrollment_classrooms, :visible, :boolean
  end
end
