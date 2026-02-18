class AddSupportUrlToGeneralConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :support_url, :string
  end
end
