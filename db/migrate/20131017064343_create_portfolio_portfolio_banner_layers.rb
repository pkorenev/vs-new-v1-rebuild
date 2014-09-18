class CreatePortfolioPortfolioBannerLayers < ActiveRecord::Migration
  def change
    create_table :portfolio_portfolio_banner_layers do |t|
      t.string :name
      t.string :style
      t.string :animation_options

      t.timestamps
    end
  end
end
