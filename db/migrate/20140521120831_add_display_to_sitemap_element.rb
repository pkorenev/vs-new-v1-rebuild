class AddDisplayToSitemapElement < ActiveRecord::Migration
  def change
    add_column :sitemap_elements, :display_on_sitemap, :boolean
  end
end
