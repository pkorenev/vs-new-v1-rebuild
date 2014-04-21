class CreateTaggableArticles < ActiveRecord::Migration
  def change
    create_table :taggable_articles do |t|
      t.text :content
      t.string :title
      t.string :name

      t.timestamps
    end
  end
end
