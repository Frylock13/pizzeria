class CreateAttributeValues < ActiveRecord::Migration
  def change
    create_table :attribute_values do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
