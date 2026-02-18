class AddTimestampsToStudentEnrollments < ActiveRecord::Migration[5.2]
  def change
    add_timestamps(:student_enrollments)
  end
end
