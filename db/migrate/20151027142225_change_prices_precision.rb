class ChangePricesPrecision < ActiveRecord::Migration
  def up
    change_column :dough_attributes, :price, :decimal, precision: 15, scale: 2
    change_column :ingredient_attributes, :price, :decimal, precision: 15, scale: 2
    change_column :pizza_attributes, :price, :decimal, precision: 15, scale: 2
    change_column :product_features, :price, :decimal, precision: 15, scale: 2
    change_column :products, :price, :decimal, precision: 15, scale: 2
  end

  def down
    change_column :dough_attributes, :price, :decimal, precision: 5, scale: 2
    change_column :ingredient_attributes, :price, :decimal, precision: 5, scale: 2
    change_column :pizza_attributes, :price, :decimal, precision: 5, scale: 2
    change_column :product_features, :price, :decimal, precision: 5, scale: 2
    change_column :products, :price, :decimal, precision: 5, scale: 2
  end
end
