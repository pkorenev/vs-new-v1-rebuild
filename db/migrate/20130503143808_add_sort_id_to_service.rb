class AddSortIdToService < ActiveRecord::Migration
  def change
    add_column :services, :sort_id, :integer
  end
end
