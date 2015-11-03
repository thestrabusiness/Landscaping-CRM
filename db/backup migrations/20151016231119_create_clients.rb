class CreateClients < ActiveRecord::Migration
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
  end
end
