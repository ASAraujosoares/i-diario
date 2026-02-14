class AddSchoolTermTypeStepToTeachingPlans < ActiveRecord::Migration[5.2]
  def change
    add_reference :teaching_plans, :school_term_type_step, index: true, foreign_key: true
  end
end
