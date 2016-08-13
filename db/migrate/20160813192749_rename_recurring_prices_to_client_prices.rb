class RenameRecurringPricesToClientPrices < ActiveRecord::Migration
  def change
    rename_table :recurring_prices, :client_prices
  end
end
