class CreateViewableResources < ActiveRecord::Migration
  def change
    create_table :viewable_resources do |t|
      t.string :anchor
      t.string :meta_keywords
      t.string :meta_title
      t.text :page_annotation
      t.text :page_description
      t.string :page_title
      t.references :viewable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
