class RemoveSchoolCalendarStepIdFromSchoolTermRecoveryDiaryRecords < ActiveRecord::Migration[5.2]
  def change
    remove_column :school_term_recovery_diary_records, :school_calendar_step_id, :integer
  end
end
