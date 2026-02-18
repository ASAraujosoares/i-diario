class RemoveTestTypeFromTestSettingTests < ActiveRecord::Migration[5.2]
  def change
    remove_column :test_setting_tests, :test_type
  end
end
