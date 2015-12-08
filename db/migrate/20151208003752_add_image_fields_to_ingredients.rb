class AddImageFieldsToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :image, :string
    add_column :ingredients, :layer, :integer
  end
end
