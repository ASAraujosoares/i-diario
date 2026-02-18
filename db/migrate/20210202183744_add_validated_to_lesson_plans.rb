class AddValidatedToLessonPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :lesson_plans, :validated, :boolean
  end
end
