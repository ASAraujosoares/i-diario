class AddKindToRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :kind, :string
  end
end
