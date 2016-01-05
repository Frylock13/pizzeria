class ChangeOwnerForeignKeyOnPizzas < ActiveRecord::Migration
  def up
    remove_foreign_key :pizzas, column: :owner_id
    add_foreign_key :pizzas, :profiles, column: :owner_id
  end

  def down
    remove_foreign_key :pizzas, column: :owner_id
    add_foreign_key :pizzas, :users, column: :owner_id
  end
end
