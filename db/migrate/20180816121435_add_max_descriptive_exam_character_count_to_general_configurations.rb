class AddMaxDescriptiveExamCharacterCountToGeneralConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :max_descriptive_exam_character_count, :integer
  end
end
