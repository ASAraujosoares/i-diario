class AddStepNumberToDescriptiveExam < ActiveRecord::Migration[5.2]
  def change
    add_column :descriptive_exams, :step_number, :integer, null: false, default: 0
  end
end
