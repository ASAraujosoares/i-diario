class DropIndexDeficienciesOnName < ActiveRecord::Migration[5.2]
  def change
    remove_index :deficiencies, "name"
  end
end
