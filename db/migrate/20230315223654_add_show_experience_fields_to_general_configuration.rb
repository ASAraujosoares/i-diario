class AddShowExperienceFieldsToGeneralConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :show_experience_fields, :boolean, default: false
  end
end
