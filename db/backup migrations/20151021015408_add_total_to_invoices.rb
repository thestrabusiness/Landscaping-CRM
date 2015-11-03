class AddTotalToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :total, :money 
  end
end
