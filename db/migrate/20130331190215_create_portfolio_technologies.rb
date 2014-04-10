class CreatePortfolioTechnologies < ActiveRecord::Migration
  def change
    create_table :portfolio_technologies do |t|
      t.string :name
      t.string :official_link
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
  end
end
