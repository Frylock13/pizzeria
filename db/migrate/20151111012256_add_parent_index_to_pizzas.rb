class AddParentIndexToPizzas < ActiveRecord::Migration
  def change
    add_index :pizzas, :parent_id
  end
end
