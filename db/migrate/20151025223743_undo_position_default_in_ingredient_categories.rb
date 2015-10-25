class UndoPositionDefaultInIngredientCategories < ActiveRecord::Migration
  def change
    change_column_default(:ingredient_categories, :position, nil)
  end
end
