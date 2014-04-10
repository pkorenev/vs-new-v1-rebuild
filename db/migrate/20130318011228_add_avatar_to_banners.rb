class AddAvatarToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :avatar_file_name, :string
    add_column :banners, :avatar_content_type, :string
    add_column :banners, :avatar_file_size, :integer
    add_column :banners, :avatar_updated_at, :datetime
  end
end
