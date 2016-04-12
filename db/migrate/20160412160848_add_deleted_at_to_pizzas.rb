class AddDeletedAtToPizzas < ActiveRecord::Migration
  def change
    add_column :pizzas, :deleted_at, :datetime
    add_index :pizzas, :deleted_at
  end
end
