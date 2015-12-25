class AddPizzaCategoryIdToPizzas < ActiveRecord::Migration
  def change
    add_reference :pizzas, :pizza_category, index: true, foreign_key: true
  end
end
