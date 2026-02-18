class AddGradesToTestSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :test_settings, :grades, :integer, array: true, default: []
  end
end
