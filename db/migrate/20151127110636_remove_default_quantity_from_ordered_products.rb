class RemoveDefaultQuantityFromOrderedProducts < ActiveRecord::Migration
  def up
    change_column :ordered_products, :quantity, :integer, default: 0
  end

  def down
    change_column :ordered_products, :quantity, :integer, default: 1
  end
end
