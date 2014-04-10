class CreateHomeBannerSlides < ActiveRecord::Migration
  def change
    create_table :home_banner_slides do |t|
      t.string :name
      t.boolean :published
      t.integer :order_number

      t.timestamps
    end
  end
end
