class AddSlugToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :slug, :string
    add_index :portfolios, :slug
  end
end
