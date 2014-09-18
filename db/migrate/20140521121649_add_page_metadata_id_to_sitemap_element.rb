class AddPageMetadataIdToSitemapElement < ActiveRecord::Migration
  def change
    add_column :sitemap_elements, :static_page_data_id, :integer
  end
end
