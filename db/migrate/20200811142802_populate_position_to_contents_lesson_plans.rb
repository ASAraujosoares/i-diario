class PopulatePositionToContentsLessonPlans < ActiveRecord::Migration[5.2]
  def change
    execute 'UPDATE contents_lesson_plans SET position = id'
  end
end
