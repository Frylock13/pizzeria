class AddHotToPizzas < ActiveRecord::Migration
  def change
    add_column :pizzas, :hot, :boolean
  end
end
