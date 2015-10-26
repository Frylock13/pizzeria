class CreateDoughs < ActiveRecord::Migration
  def change
    create_table :doughs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
