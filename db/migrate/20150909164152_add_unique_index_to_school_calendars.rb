class AddUniqueIndexToSchoolCalendars < ActiveRecord::Migration[5.2]
  def change
    add_index :school_calendars, [:year, :unity_id], unique: true
  end
end
