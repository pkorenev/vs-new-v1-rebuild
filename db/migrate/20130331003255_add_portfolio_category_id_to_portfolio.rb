class AddPortfolioCategoryIdToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :portfolio_category_id, :integer
  end
end
