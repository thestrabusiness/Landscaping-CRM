class AddBalanceToClients < ActiveRecord::Migration
  def change
    add_column :clients, :balance, :decimal
  end
end
