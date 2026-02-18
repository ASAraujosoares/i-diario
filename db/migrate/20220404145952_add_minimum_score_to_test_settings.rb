class AddMinimumScoreToTestSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :test_settings, :minimum_score, :integer, default: 0, null: false
  end
end
