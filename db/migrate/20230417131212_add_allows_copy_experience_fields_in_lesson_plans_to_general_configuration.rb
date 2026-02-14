class AddAllowsCopyExperienceFieldsInLessonPlansToGeneralConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :allows_copy_experience_fields_in_lesson_plans, :boolean, default: false
  end
end
