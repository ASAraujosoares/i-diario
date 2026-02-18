class AddNotNullToSchoolCalendarClassroomsClassroomId < ActiveRecord::Migration[5.2]
  def change
    change_column_null :school_calendar_classrooms, :classroom_id, false
  end
end
