class ChangClientIdColumn < ActiveRecord::Migration
  def change
    rename_column :clients, :client_id, :id
  end
end
