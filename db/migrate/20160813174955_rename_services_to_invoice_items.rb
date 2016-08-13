class RenameServicesToInvoiceItems < ActiveRecord::Migration
  def change
    rename_table :services, :invoice_items
  end
end
