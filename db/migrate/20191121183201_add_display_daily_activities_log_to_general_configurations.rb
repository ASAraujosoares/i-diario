class AddDisplayDailyActivitiesLogToGeneralConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :display_daily_activies_log, :boolean, default: false
  end
end
