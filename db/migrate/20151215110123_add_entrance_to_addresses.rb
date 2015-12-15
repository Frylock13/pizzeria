class AddEntranceToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :entrance, :string, limit: 10
  end
end
