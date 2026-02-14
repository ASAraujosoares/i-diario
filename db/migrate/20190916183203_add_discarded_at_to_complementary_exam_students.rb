class AddDiscardedAtToComplementaryExamStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :complementary_exam_students, :discarded_at, :datetime
  end
end
