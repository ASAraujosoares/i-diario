class RemoveSchoolTermTypeFromTeachingPlans < ActiveRecord::Migration[5.2]
  def change
    remove_column :teaching_plans, :school_term_type
  end
end
