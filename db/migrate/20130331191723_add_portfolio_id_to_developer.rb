class AddPortfolioIdToDeveloper < ActiveRecord::Migration
  def change
    add_column :developers, :portfolio_id, :integer
  end
end
