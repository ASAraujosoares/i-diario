class AddPositionToObjectivesTeachingPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :objectives_teaching_plans, :position, :integer, null: true
  end
end
