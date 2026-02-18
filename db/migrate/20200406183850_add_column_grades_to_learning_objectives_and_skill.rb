class AddColumnGradesToLearningObjectivesAndSkill < ActiveRecord::Migration[5.2]
  def change
    add_column :learning_objectives_and_skills, :grades, :string, array: true, default: []
  end
end
