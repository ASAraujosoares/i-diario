class AddSequenceToKnowledgeAreas < ActiveRecord::Migration[5.2]
  def change
    add_column :knowledge_areas, :sequence, :integer
  end
end
