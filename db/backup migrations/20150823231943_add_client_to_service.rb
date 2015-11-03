class AddClientToService < ActiveRecord::Migration
  def change
    add_reference :services, :client, index: true
  end
end
