class CreateSitemapElements < ActiveRecord::Migration
  def change
    create_table :sitemap_elements do |t|
      t.string :path
      t.string :url
      t.string :changefreq
      t.float :priority
      t.datetime :lastmod
      t.integer :sitemappable_id
      t.string :sitemappable_type

      t.timestamps
    end
  end
end
