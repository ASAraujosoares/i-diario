class AddStepTypeDescriptionToSchoolCalendars < ActiveRecord::Migration[5.2]
  def change
    add_column :school_calendars, :step_type_description, :string
  end
end
