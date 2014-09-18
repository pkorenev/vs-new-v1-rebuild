class AddSlugToPortfolioCatalog < ActiveRecord::Migration
  def change
    add_column :portfolio_categories, :slug, :string
    add_index :portfolio_categories, :slug
  end
end
