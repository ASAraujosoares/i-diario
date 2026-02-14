class AddSequenceToDailyFrequencyStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_frequency_students, :sequence, :integer
  end
end
