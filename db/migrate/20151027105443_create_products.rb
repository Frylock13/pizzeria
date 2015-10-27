class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.text :description
      t.integer :weight
      t.decimal :price, precision: 5, scale: 2
      t.references :product_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
