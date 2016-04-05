class AddVisibilityToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :visibility, :integer, default: 0
  end
end
