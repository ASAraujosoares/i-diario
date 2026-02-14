class AddCopyrightNameToGeneralConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :copyright_name, :string
  end
end
