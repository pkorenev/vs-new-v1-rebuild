class AddParamsToPortfolioBanner < ActiveRecord::Migration
  def change
    add_column :portfolio_banners, :title, :string
    add_column :portfolio_banners, :background_file_name, :string
    add_column :portfolio_banners, :background_content_type, :string
    add_column :portfolio_banners, :background_file_size, :integer
    add_column :portfolio_banners, :background_updated_at, :datetime
  end
end
