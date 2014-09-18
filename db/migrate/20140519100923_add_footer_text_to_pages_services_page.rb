class AddFooterTextToPagesServicesPage < ActiveRecord::Migration
  def change
    add_column :pages_services_pages, :footer_text, :text
  end
end
