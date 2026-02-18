class AddCurrentSchoolYearToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_school_year, :integer
  end
end
