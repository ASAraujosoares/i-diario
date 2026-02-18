class AddPeriodToClassrooms < ActiveRecord::Migration[5.2]
  def change
    add_column :classrooms, :period, :string
  end
end
