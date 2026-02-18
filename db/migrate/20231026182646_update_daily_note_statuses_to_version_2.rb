class UpdateDailyNoteStatusesToVersion2 < ActiveRecord::Migration[5.2]
  def change
    # Ruby 3 syntax fix: ensure the hash is passed explicitly
    # If replace_view expects 1 argument, it likely means 'view_name' and keywords.
    # We pass the name as the first arg, and the rest as keyword arguments.
    replace_view :daily_note_statuses, version: 2, revert_to_version: 1
  end
end
