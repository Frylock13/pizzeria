class AddProfilesToCallRequests < ActiveRecord::Migration
  def change
    rename_column :call_requests, :profile_id, :ordering_profile_id
    add_column :call_requests, :receiving_profile_id, :integer
    add_index :call_requests, :receiving_profile_id
  end
end
