class AddPublishedToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :published, :boolean
  end
end
