class CreateIngredientCategories < ActiveRecord::Migration
  def change
    create_table :ingredient_categories do |t|
      t.string :name
      t.integer :position, default: 0

      t.timestamps null: false
    end
  end
end
