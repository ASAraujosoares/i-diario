class RemoveColumnDependenceFromDailyFrequencyStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :daily_frequency_students, :dependence, :boolean
  end
end
