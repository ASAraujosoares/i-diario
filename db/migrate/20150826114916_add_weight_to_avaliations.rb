class AddWeightToAvaliations < ActiveRecord::Migration[5.2]
  def change
    add_column :avaliations, :weight, :decimal, null: true
  end
end
