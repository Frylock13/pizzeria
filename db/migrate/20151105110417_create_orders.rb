class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :address, index: true, foreign_key: true
      t.integer :status
      t.text :wishes
      t.integer :receiving_profile_id
      t.integer :ordering_profile_id
      t.integer :payment_method
      t.datetime :booked_on

      t.timestamps null: false
    end
    add_index :orders, :status
    add_index :orders, :receiving_profile_id
    add_index :orders, :ordering_profile_id
    add_index :orders, :payment_method
  end
end
