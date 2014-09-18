class CreateHomeBannerSlideLayers < ActiveRecord::Migration
  def change
    create_table :home_banner_slide_layers do |t|
      t.string :name
      t.text :content
      t.text :style
      t.text :options

      t.timestamps
    end
  end
end
