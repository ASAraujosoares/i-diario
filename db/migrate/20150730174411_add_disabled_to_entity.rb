class AddDisabledToEntity < ActiveRecord::Migration[5.2]
  def change
    add_column :entities, :disabled, :boolean, default: false
  end
end
