class AddFieldsToProfiles < ActiveRecord::Migration
  def change
    remove_index :profiles, :user_id
    remove_column :profiles, :user_id, :integer
    add_column :profiles, :phone, :string
    add_column :profiles, :email, :string
    add_column :profiles, :owner_id, :integer
    add_index :profiles, :email
    add_index :profiles, :owner_id
  end
end
