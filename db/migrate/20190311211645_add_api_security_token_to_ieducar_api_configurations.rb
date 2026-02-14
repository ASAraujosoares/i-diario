class AddApiSecurityTokenToIeducarApiConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_column :ieducar_api_configurations, :api_security_token, :string
  end
end
