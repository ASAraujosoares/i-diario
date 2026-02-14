class RemoveColumnKindFromRole < ActiveRecord::Migration[5.2]
  def change
    remove_column :roles, :kind, :string
  end
end
