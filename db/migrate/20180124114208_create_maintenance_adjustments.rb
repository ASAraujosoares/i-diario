class CreateMaintenanceAdjustments < ActiveRecord::Migration[5.2]
  def change
    create_table :maintenance_adjustments do |t|
      t.integer :year
      t.string :kind
      t.text :observations
      t.string :status

      t.timestamps null: false
    end
  end
end
