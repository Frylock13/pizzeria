class AddSpicyToPizzas < ActiveRecord::Migration
  def change
    add_column :pizzas, :spicy, :boolean
  end
end
