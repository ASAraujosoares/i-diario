class AddUnitiesToTestSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :test_settings, :unities, :integer, array: true, default: []
  end
end
