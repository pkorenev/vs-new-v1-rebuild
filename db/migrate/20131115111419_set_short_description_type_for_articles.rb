class SetShortDescriptionTypeForArticles < ActiveRecord::Migration
  def change
  	change_column :articles, :short_description, :text
  end
end
