class CreateStaticPageData < ActiveRecord::Migration
  def change
    create_table :static_page_data do |t|
      t.string :url
      t.string :body_title
      t.string :head_title
      t.text :meta_keywords
      t.text :meta_description

      t.integer :has_static_page_data_id
      t.string :has_static_page_data_type

      t.timestamps
    end
  end
end
