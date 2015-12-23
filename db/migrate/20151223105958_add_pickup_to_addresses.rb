class AddPickupToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :pickup, :boolean
  end
end
