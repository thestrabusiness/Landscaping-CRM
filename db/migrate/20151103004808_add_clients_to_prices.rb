class AddClientsToPrices < ActiveRecord::Migration
  def change
    add_reference :recurring_prices, :client, index:true
  end
end
