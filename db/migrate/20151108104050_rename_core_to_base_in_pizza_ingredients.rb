class RenameCoreToBaseInPizzaIngredients < ActiveRecord::Migration
  def change
    rename_column :pizza_ingredients, :core, :base
  end
end
