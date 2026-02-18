class AddUnityIdToSchoolCalendars < ActiveRecord::Migration[5.2]
  def change
    add_reference(:school_calendars, :unity, index: true, foreign_key: true)
  end
end
