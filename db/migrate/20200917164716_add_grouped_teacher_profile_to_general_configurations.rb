class AddGroupedTeacherProfileToGeneralConfigurations < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :grouped_teacher_profile, :boolean, default: false, null: false
  end
end
