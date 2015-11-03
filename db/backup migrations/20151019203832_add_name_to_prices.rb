class AddNameToPrices < ActiveRecord::Migration
  def change
    add_column :recurring_prices, :name, :string
  end
end
