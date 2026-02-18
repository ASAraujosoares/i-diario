class AddActivedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :actived_at, :datetime
  end
end
