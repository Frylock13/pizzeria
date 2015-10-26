class CreatePizzaIngredients < ActiveRecord::Migration
  def change
    create_table :pizza_ingredients do |t|
      t.references :pizza, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true
      t.integer :quantity, default: 1
      t.boolean :core, default: false

      t.timestamps null: false
    end
  end
end
