class AddSynchronizedAtToIeducarApiConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_column :ieducar_api_configurations, :synchronized_at, :datetime
  end
end
