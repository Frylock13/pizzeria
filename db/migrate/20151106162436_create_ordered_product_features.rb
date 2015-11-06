class CreateOrderedProductFeatures < ActiveRecord::Migration
  def change
    create_table :ordered_product_features do |t|
      t.references :ordered_product, index: true, foreign_key: true
      t.references :product_feature, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
