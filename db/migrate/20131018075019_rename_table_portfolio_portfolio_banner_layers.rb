class RenameTablePortfolioPortfolioBannerLayers < ActiveRecord::Migration
  def change
  	rename_table :portfolio_portfolio_banner_layers, :portfolio_banner_layers
  end
end
