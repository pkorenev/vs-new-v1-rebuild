class AddNameEngToPortfolioCategory < ActiveRecord::Migration
  def change
    add_column :portfolio_categories, :name_eng, :string
  end
end
