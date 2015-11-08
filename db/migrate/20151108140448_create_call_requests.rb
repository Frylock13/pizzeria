class CreateCallRequests < ActiveRecord::Migration
  def change
    create_table :call_requests do |t|
      t.references :profile, index: true, foreign_key: true
      t.string :wishes

      t.timestamps null: false
    end
  end
end
