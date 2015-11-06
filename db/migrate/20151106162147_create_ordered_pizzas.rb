class CreateOrderedPizzas < ActiveRecord::Migration
  def change
    create_table :ordered_pizzas do |t|
      t.references :order, index: true, foreign_key: true
      t.references :pizza, index: true, foreign_key: true
      t.integer :quantity, default: 1
      t.integer :pizza_size

      t.timestamps null: false
    end
  end
end
