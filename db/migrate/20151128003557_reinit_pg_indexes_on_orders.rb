class ReinitPgIndexesOnOrders < ActiveRecord::Migration
  def change
    remove_index :orders, :status
    add_index :orders, :status
    remove_index :orders, :payment_method
    add_index :orders, :payment_method
  end
end
