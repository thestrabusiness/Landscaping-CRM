class CreateRecurringServices < ActiveRecord::Migration
  def change
    create_table :recurring_services do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
