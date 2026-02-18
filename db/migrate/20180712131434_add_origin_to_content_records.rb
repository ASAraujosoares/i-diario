class AddOriginToContentRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :content_records, :origin, :string
  end
end
