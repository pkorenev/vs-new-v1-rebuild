class AddPortfolioTechnologyIdToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :portfolio_technology_id, :integer
  end
end
