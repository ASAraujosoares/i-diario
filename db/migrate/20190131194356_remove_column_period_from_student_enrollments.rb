class RemoveColumnPeriodFromStudentEnrollments < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_enrollments, :period, :integer
  end
end
