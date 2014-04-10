class AddPortfolioIdToPortfolioCategories < ActiveRecord::Migration
  def change
    add_column :portfolio_categories, :portfolio_id, :integer
  end
end
