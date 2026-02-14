class RemoveUsersCreationFromMaintenanceAdjustments < ActiveRecord::Migration[5.2]
  def change
    MaintenanceAdjustment.where(kind: 'creating_users_for_students').each(&:destroy)
  end
end
