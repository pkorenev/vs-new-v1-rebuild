class ModifyPortfolio < ActiveRecord::Migration
  def change
  	add_column :portfolios, :description, :text
  	add_column :portfolios, :thanks_to, :text
  end
end
