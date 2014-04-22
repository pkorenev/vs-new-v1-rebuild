class CreatePagesServicesPages < ActiveRecord::Migration
  def change
    create_table :pages_services_pages do |t|

      t.timestamps
    end
  end
end
