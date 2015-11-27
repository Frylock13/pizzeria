class RemoveDefaultQuantityFromOrderedPizzas < ActiveRecord::Migration
  def up
    change_column :ordered_pizzas, :quantity, :integer, default: 0
  end

  def down
    change_column :ordered_pizzas, :quantity, :integer, default: 1
  end
end
