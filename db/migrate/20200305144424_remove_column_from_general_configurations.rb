class RemoveColumnFromGeneralConfigurations < ActiveRecord::Migration[5.2]
  def change
    remove_column :general_configurations, :display_knowledge_area_as_discipline
  end
end
