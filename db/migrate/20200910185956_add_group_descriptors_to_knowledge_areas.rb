class AddGroupDescriptorsToKnowledgeAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :knowledge_areas, :group_descriptors, :boolean, default: false
  end
end
