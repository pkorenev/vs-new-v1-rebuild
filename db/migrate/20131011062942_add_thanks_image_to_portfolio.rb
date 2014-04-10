class AddThanksImageToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :thanks_image_file_name, :string
    add_column :portfolios, :thanks_image_content_type, :string
    add_column :portfolios, :thanks_image_file_size, :integer
    add_column :portfolios, :thanks_image_updated_at, :string
  end
end
