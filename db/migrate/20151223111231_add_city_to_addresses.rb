class AddCityToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :city, :string, limit: 50
  end
end
