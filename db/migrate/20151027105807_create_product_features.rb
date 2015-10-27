class CreateProductFeatures < ActiveRecord::Migration
  def change
    create_table :product_features do |t|
      t.references :product, index: true, foreign_key: true
      t.references :feature, index: true, foreign_key: true
      t.references :feature_value, index: true, foreign_key: true
      t.decimal :price, precision: 5, scale: 2
      t.integer :weight

      t.timestamps null: false
    end
    add_index :product_features,
              [:product_id, :feature_id, :feature_value_id],
              name: 'index_product_features_compound_key', unique: true
  end
end
