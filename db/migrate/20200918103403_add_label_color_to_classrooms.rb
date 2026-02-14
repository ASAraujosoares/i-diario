class AddLabelColorToClassrooms < ActiveRecord::Migration[5.2]
  def change
    add_column :classrooms, :label_color, :string
  end
end
