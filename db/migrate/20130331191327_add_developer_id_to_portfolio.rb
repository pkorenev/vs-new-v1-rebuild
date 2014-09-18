class AddDeveloperIdToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :developer_id, :integer
  end
end
