class AddErrorMessageToGeneralConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :error_message, :string
  end
end
