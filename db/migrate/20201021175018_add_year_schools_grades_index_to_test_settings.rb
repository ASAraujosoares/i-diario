class AddYearSchoolsGradesIndexToTestSettings < ActiveRecord::Migration[5.2]
  def change
    add_index :test_settings, [:year, :unities, :grades], unique: true, where: "unities <> '{}'"
  end
end
