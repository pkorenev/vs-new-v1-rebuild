class CreatePagesHomePages < ActiveRecord::Migration
  def change
    create_table :pages_home_pages do |t|
      t.text :greetings

      t.timestamps
    end
  end
end
