class AddDisciplineToLearningObjectivesAndSkills < ActiveRecord::Migration[5.2]
  def change
    add_column :learning_objectives_and_skills, :discipline, :string
  end
end
