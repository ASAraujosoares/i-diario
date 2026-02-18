class AddSequenceToDisciplines < ActiveRecord::Migration[5.2]
  def change
    add_column :disciplines, :sequence, :integer
  end
end
