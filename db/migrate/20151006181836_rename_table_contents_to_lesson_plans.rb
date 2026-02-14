class RenameTableContentsToLessonPlans < ActiveRecord::Migration[5.2]
  def change
    rename_table :contents, :lesson_plans
  end
end
