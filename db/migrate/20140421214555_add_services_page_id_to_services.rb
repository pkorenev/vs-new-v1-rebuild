class AddServicesPageIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :services_page_id, :integer
    add_column :services, :avatar_alt, :string

  end
end
