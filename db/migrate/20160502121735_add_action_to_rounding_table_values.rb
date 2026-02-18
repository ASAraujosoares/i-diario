class AddActionToRoundingTableValues < ActiveRecord::Migration[5.2]
  def change
    add_column :rounding_table_values, :action, :integer
  end
end
