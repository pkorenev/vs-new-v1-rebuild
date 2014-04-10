class CreatePortfolioBanners < ActiveRecord::Migration
  def change
    create_table :portfolio_banners do |t|
      t.string :name
      t.text :content
      t.integer :portfolio_id

      t.timestamps
    end
  end
end
