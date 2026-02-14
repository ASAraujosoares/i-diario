class ChangeColumnUnityEquipmentsCodeType < ActiveRecord::Migration[5.2]
  def change
    change_column :unity_equipments, :code, :string
  end
end
