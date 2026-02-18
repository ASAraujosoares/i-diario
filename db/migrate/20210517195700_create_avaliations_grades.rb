class CreateAvaliationsGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :avaliations_grades do |t|
      t.belongs_to :avaliation
      t.belongs_to :grade
      t.timestamps
    end
  end
end
