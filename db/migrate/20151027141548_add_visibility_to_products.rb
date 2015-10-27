class AddVisibilityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :visibility, :integer, default: 0
  end
end
