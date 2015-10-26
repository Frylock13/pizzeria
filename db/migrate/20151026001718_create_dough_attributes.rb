class CreateDoughAttributes < ActiveRecord::Migration
  def change
    create_table :dough_attributes do |t|
      t.references :dough, index: true, foreign_key: true
      t.integer :pizza_size
      t.decimal :price, precision: 5, scale: 2
      t.integer :weight

      t.timestamps null: false
    end
  end
end
