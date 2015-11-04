class BuildDb < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :billing_address
      t.string :job_address
      t.string :city
      t.string :state
      t.string :zip
      t.money :balance

      t.timestamps null: false
    end
    
    create_table :invoices do |t|
      t.datetime :date
      t.string :performed_by
      t.string :status
      t.string :note
      t.money :total
      t.references :client, index: true

      t.timestamps null: false
    end
    
    create_table :services do |t|
      t.string :name
      t.string :category
      t.integer :quantity
      t.money :price
      t.references :invoice, index: true, foreign_key: true
      

      t.timestamps null: false
    end
      
    add_reference :services, :client, index: true
    
    create_table :recurring_services do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :recurring_prices do |t|
      t.string :name
      t.money :price
      t.references :clients, index: true

      t.timestamps null: false
    end
  end
end
