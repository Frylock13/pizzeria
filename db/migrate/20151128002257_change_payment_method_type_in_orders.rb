class ChangePaymentMethodTypeInOrders < ActiveRecord::Migration
  def change
    change_column :orders, :payment_method, :string
  end
end
