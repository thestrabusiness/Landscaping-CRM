class CreateEstimateItems < ActiveRecord::Migration
  def change
    create_table :estimate_items do |t|
      t.references :estimate, index: true, foreign_key: true
      t.string :name
      t.money :price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
