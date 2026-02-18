class ChangeColumnUpdatedAtToStringOnStudentEnrollments < ActiveRecord::Migration[5.2]
  def change
    change_column :student_enrollments, :updated_at, :string
  end
end
