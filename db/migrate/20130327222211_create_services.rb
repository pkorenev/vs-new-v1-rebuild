class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.boolean :published
      t.string :name
      t.text :short_description
      t.text :full_description
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
  end
end
