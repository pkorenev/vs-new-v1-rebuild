class AddTaskToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :task, :text
  end
end
