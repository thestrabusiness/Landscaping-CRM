class RemoveClientsIdFromRecurringPrices < ActiveRecord::Migration
  def change
    remove_column :recurring_prices, :clients_id
  end
end
