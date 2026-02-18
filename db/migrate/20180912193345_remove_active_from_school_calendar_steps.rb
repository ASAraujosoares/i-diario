class RemoveActiveFromSchoolCalendarSteps < ActiveRecord::Migration[5.2]
  def change
    remove_column :school_calendar_steps, :active, :boolean
  end
end
