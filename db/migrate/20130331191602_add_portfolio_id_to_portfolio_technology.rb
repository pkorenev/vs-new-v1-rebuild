class AddPortfolioIdToPortfolioTechnology < ActiveRecord::Migration
  def change
    add_column :portfolio_technologies, :portfolio_id, :integer
  end
end
