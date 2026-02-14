class AddTeacherIdToTeachingPlans < ActiveRecord::Migration[5.2]
  def change
    add_reference :teaching_plans, :teacher, index: true, foreign_key: true
  end
end
