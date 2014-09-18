class AddIntroToPagesPortfolioListPages < ActiveRecord::Migration
  def change
    add_column :pages_portfolio_list_pages, :intro_text, :text
  end
end
