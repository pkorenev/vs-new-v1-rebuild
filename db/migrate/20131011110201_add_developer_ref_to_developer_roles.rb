class AddDeveloperRefToDeveloperRoles < ActiveRecord::Migration
  def change
  	add_index(:developer_roles, :developer_id)
  end
end
