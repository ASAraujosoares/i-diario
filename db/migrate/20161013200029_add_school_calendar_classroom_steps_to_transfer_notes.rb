class AddSchoolCalendarClassroomStepsToTransferNotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :transfer_notes, :school_calendar_classroom_step, index: true, foreign_key: true
  end
end
