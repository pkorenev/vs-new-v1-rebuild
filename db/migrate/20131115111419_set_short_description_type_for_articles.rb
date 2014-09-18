class SetShortDescriptionTypeForArticles < ActiveRecord::Migration
  def up
  	change_column :articles, :short_description, :text
  end

  def down
    change_column :articles, :short_description, :string
  end
end
