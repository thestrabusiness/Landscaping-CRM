class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.datetime :date
      t.money :total
      t.string :notes
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
