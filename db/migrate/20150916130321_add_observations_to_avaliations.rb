class AddObservationsToAvaliations < ActiveRecord::Migration[5.2]
  def change
    add_column :avaliations, :observations, :text
  end
end
