class AddApiCodeIndexToDisciplines < ActiveRecord::Migration[5.2]
  def change
    execute "DROP INDEX IF EXISTS index_disciplines_on_api_code "
    add_index :disciplines, :api_code, unique: true
  end
end
