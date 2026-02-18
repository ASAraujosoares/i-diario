class AddDailyActivitiesRecordToContentRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :content_records, :daily_activities_record, :text
  end
end
