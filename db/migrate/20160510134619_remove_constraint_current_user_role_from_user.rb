class RemoveConstraintCurrentUserRoleFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :current_user_role_id
    remove_foreign_key :users, :user_roles
  end
end
