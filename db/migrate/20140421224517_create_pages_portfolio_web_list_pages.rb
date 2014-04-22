class CreatePagesPortfolioWebListPages < ActiveRecord::Migration
  def change
    create_table :pages_portfolio_web_list_pages do |t|

      t.timestamps
    end
  end
end
