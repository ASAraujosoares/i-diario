class UpdateDailyNoteStatusesToVersion2 < ActiveRecord::Migration[5.2]
  def change
    # FIX: Use Ruby 3 keyword arguments (no curly braces)
    # This matches the signature: replace_view(name, version: nil, revert_to_version: nil, ...)
    replace_view :daily_note_statuses, version: 2, revert_to_version: 1
  end
end
