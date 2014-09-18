class CreatePageMetadata < ActiveRecord::Migration
  def change
    create_table :page_metadata do |t|
      t.string :path
      t.text :meta_description
      t.text :meta_keywords

      t.integer :metataggable_id
      t.string :metataggable_type

      t.timestamps
    end
  end
end
