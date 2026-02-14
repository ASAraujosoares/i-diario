class RemoveSchoolCalendarStepIdFromDescriptiveExams < ActiveRecord::Migration[5.2]
  def change
    remove_column :descriptive_exams, :school_calendar_step_id, :integer
  end
end
