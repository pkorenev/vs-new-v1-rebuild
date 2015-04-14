class AddDataFileNameFallbackToCkeditorAssets < ActiveRecord::Migration
  def change
    add_column :ckeditor_assets, :data_file_name_fallback, :string
  end
end
