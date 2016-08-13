class RenameRecurringServicesToServices < ActiveRecord::Migration
  def change
    rename_table :recurring_services, :services
  end
end
