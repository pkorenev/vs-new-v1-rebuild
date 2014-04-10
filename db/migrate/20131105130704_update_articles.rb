class UpdateArticles < ActiveRecord::Migration
	def change
		add_column :articles, :release_date, :datetime
		rename_column :articles, :full_description, :content
	end
end
