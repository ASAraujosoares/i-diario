class AddCurrentUnityIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_unity_id, :integer
  end
end
