class AddHomeBannerSlideToHomeBannerSlideLayer < ActiveRecord::Migration
  def change
    add_column :home_banner_slide_layers, :home_banner_slide_id, :integer
  end
end
