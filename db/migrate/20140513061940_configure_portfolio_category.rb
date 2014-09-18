class ConfigurePortfolioCategory < ActiveRecord::Migration
  def change
    add_column :portfolio_categories, :title, :string
    rename_column :portfolio_categories, :slug, :url
  end
end
