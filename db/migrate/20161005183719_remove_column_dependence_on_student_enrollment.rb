class RemoveColumnDependenceOnStudentEnrollment < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_enrollments, :dependence
  end
end
