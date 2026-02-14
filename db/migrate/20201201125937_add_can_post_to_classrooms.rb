class AddCanPostToClassrooms < ActiveRecord::Migration[5.2]
  def change
    add_column :classrooms, :can_post, :boolean, default: true
  end
end
