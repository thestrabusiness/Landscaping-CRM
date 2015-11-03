class RemoveRecurringServiceIdFromRecurringPrice < ActiveRecord::Migration
  def change
    remove_column :recurring_prices, :recurring_service_id 
  end
end
