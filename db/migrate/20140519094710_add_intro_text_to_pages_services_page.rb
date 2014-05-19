class AddIntroTextToPagesServicesPage < ActiveRecord::Migration
  def change
    add_column :pages_services_pages, :intro_text, :text
  end
end
