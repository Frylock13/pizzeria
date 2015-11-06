class RenameUserIdOnPizzas < ActiveRecord::Migration
  def change
    rename_column :pizzas, :user_id, :owner_id
  end
end
