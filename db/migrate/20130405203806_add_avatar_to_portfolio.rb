class AddAvatarToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :avatar_file_name, :string
    add_column :portfolios, :avatar_content_type, :string
    add_column :portfolios, :avatar_file_size, :integer
    add_column :portfolios, :avatar_updated_at, :datetime
    add_column :portfolios, :result, :text
    add_column :portfolios, :result_eng, :text
    add_column :portfolios, :process, :text
    add_column :portfolios, :process_eng, :text
    add_column :portfolios, :live, :text
    add_column :portfolios, :live_eng, :text
    add_column :portfolios, :release, :date
    add_column :portfolios, :published, :boolean
  end
end
