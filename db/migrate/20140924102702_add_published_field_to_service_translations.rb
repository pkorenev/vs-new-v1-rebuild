class AddPublishedFieldToServiceTranslations < ActiveRecord::Migration
  def change
    change_table Service.translation_class.table_name do |t|
      t.boolean :published
    end
  end
end
