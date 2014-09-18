class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.integer :developer_role_id
      t.string :facebook_profile
      t.string :vkontakte_profile
      t.string :twitter_profile

      t.timestamps
    end
  end
end
