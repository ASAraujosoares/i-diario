class RemoveSchoolCalendarStepIdFromTeachingPlans < ActiveRecord::Migration[5.2]
  def change
    remove_column :teaching_plans, :school_calendar_step_id
  end
end
