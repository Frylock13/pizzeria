class AddCardsFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :discount_card_number, :string
    add_column :orders, :discount_in_percents, :decimal, precision: 5, scale: 2
  end
end
