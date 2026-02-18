class AddDefaultDivisionWeightToTestSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :test_settings, :default_division_weight, :integer, default: 1
  end
end
