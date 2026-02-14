class RemoveFixTestsFromTestSettings < ActiveRecord::Migration[5.2]
  def change
    remove_column :test_settings, :fix_tests, :boolean
  end
end
