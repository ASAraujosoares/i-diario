class RemoveClassroomIdFromStudentEnrollmentClassrooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_enrollment_classrooms, :classroom_id
  end
end
