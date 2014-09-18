class CreateTrustCompanies < ActiveRecord::Migration
  def change
    create_table :trust_companies do |t|
      t.boolean :published
      t.string :name
      t.string :description
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
  end
end
