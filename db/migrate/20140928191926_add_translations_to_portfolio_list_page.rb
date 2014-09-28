class AddTranslationsToPortfolioListPage < ActiveRecord::Migration
  def up
    Pages::PortfolioListPage.create_translation_table!
  end

  def down
    Pages::PortfolioListPage.drop_translation_table!
  end
end
