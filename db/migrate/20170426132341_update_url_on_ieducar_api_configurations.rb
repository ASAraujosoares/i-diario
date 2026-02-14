class UpdateUrlOnIeducarApiConfigurations < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      UPDATE ieducar_api_configurations SET url = replace(url, 'http://', 'https://');
    SQL
  end
end
