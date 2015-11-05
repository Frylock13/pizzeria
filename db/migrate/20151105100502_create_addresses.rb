class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :owner_id
      t.string :street, limit: 50
      t.string :house, limit: 10
      t.string :flat, limit: 10
      t.string :floor, limit: 10
      t.string :intercom_code, limit: 10

      t.timestamps null: false
    end
    add_index :addresses, :owner_id
  end
end
