class AddStepNumberToComplementaryExam < ActiveRecord::Migration[5.2]
  def change
    add_column :complementary_exams, :step_number, :integer, null: false, default: 0
  end
end
