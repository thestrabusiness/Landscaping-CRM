class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.datetime :date
      t.string :performed_by
      t.string :status
      t.string :note
      t.references :client, index: true

      t.timestamps null: false
    end
  end
end
