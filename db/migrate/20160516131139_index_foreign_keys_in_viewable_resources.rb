class IndexForeignKeysInViewableResources < ActiveRecord::Migration
  def change
    add_index :viewable_resources, :viewable_id
  end
end
