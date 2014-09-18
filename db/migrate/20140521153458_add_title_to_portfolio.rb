class AddTitleToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :title, :string
  end
end
