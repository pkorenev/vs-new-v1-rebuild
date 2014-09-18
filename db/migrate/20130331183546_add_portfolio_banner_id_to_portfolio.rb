class AddPortfolioBannerIdToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :portfolio_banner_id, :integer
  end
end
