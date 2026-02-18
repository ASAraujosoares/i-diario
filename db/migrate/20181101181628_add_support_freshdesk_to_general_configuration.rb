class AddSupportFreshdeskToGeneralConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :general_configurations, :support_freshdesk, :string
  end
end
