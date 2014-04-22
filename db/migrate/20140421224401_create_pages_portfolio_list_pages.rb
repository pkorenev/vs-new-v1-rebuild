class CreatePagesPortfolioListPages < ActiveRecord::Migration
  def change
    create_table :pages_portfolio_list_pages do |t|

      t.timestamps
    end
  end
end
