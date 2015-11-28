class ChangeStatusTypeInOrders < ActiveRecord::Migration
  def change
    change_column :orders, :status, :string
  end
end
