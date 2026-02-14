class AddStepTypeDescriptionToSchoolCalendarClassrooms < ActiveRecord::Migration[5.2]
  def change
    add_column :school_calendar_classrooms, :step_type_description, :string
  end
end
