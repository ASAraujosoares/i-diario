class RemoveStudentBioetricsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :student_biometrics
  end
end
