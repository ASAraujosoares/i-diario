class AddOriginToDailyFrequencies < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_frequencies, :origin, :string
  end
end
