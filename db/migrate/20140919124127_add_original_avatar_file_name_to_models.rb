class AddOriginalAvatarFileNameToModels < ActiveRecord::Migration
  def change
    [Service, Article, TrustCompany, Portfolio::Portfolio, Portfolio::PortfolioTechnology, Developer].each do |model|
      change_table model.table_name do |t|
        t.string :avatar_file_name_fallback
      end
    end

    change_table Portfolio::PortfolioBanner.table_name do |t|
      t.string :background_file_name_fallback
    end
  end
end
