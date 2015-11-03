class CreateRecurringPrices < ActiveRecord::Migration
  def change
    create_table :recurring_prices do |t|
      t.money :price
      t.references :clients, index: true
      t.references :recurring_services, index: true

      t.timestamps null: false
    end
  end
end
