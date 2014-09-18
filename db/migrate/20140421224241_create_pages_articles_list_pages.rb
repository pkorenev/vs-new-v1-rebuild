class CreatePagesArticlesListPages < ActiveRecord::Migration
  def change
    create_table :pages_articles_list_pages do |t|

      t.timestamps
    end
  end
end
