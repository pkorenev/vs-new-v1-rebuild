class AddDeveloperRoleRefToDevelopers < ActiveRecord::Migration
  def change
    #add_reference :developers, :developer_role, index: true
    #remove_column :developers, :developer_role_id
    #add_reference :developers, :developer_role, index: true

    add_index :developers, :developer_role_id
  end
end
