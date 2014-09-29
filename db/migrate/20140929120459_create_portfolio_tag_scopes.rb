class CreatePortfolioTagScopes < ActiveRecord::Migration
  def change
    create_table :portfolio_tag_scopes do |t|
      t.integer :scope_taggable_id
      t.string :scope_taggable_type
      t.timestamps
    end
  end
end
