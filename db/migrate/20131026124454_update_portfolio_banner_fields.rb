class UpdatePortfolioBannerFields < ActiveRecord::Migration
	def change
		rename_column :portfolio_banners, :content, :description
		change_column :portfolio_banners, :description, :text
		change_column :portfolio_banners, :title, :text
	end
end
