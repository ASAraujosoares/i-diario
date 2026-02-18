class AddRecordedAtToDescriptiveExams < ActiveRecord::Migration[5.2]
  def change
    add_column :descriptive_exams, :recorded_at, :date
  end
end
