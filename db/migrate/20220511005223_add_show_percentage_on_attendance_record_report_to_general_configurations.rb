class AddShowPercentageOnAttendanceRecordReportToGeneralConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :show_percentage_on_attendance_record_report, :boolean, default: false
  end
end
