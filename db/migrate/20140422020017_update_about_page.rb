class UpdateAboutPage < ActiveRecord::Migration
  def change
    add_column :pages_about_pages, :clients_intro, :text
    add_column :pages_about_pages, :team_text, :text
  end
end
