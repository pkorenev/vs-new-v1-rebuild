class AddSlugToServices < ActiveRecord::Migration
  def change
    add_column :services, :slug, :string
  end
end
