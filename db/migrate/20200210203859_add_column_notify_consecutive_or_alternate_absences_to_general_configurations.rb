class AddColumnNotifyConsecutiveOrAlternateAbsencesToGeneralConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :notify_consecutive_or_alternate_absences, :boolean, default: false
  end
end
