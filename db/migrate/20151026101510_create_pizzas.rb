class CreatePizzas < ActiveRecord::Migration
  def change
    create_table :pizzas do |t|
      t.string :name
      t.string :image
      t.integer :visibility, default: 0
      t.references :user, index: true, foreign_key: true
      t.references :dough, index: true, foreign_key: true
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
