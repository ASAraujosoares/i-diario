class RemoveUnityIdFromAvaliations < ActiveRecord::Migration[5.2]
  def change
    remove_column :avaliations, :unity_id
  end
end
