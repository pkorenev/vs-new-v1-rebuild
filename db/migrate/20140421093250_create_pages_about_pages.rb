class CreatePagesAboutPages < ActiveRecord::Migration
  def change
    create_table :pages_about_pages do |t|
      t.text :content

      t.timestamps
    end
  end
end
