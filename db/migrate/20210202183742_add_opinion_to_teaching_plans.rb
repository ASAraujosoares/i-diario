class AddOpinionToTeachingPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :teaching_plans, :opinion, :text
  end
end
