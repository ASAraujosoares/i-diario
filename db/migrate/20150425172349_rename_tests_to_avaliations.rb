class RenameTestsToAvaliations < ActiveRecord::Migration[5.2]
  def change
    rename_table :tests, :avaliations
  end
end
