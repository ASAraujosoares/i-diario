class AddColumnDisconsiderDifferentiatedExamRuleToDeficiencies < ActiveRecord::Migration[5.2]
  def change
    add_column :deficiencies, :disconsider_differentiated_exam_rule, :boolean, default: false, null: false
  end
end
