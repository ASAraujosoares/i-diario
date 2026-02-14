class AddUniqueIndexOnSchoolTermTypes < ActiveRecord::Migration[5.2]
  def change
    add_index :school_term_types, :description, unique: true
  end
end
