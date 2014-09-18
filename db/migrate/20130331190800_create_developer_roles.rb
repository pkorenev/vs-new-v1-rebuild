class CreateDeveloperRoles < ActiveRecord::Migration
  def change
    create_table :developer_roles do |t|
      t.string :name
      t.integer :developer_id

      t.timestamps
    end
  end
end
