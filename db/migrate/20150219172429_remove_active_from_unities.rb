class RemoveActiveFromUnities < ActiveRecord::Migration[5.2]
  def change
    remove_column :unities, :active
  end
end
