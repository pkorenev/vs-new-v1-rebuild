class AddContentToContactsPages < ActiveRecord::Migration
  def up
    [Pages::ContactPage, Pages::OrderPage, Pages::JoinUsPage].each do |model|
      change_table model.table_name do |t|
        t.text :content
      end

      model.create_translation_table!
    end
  end

  def down
    [Pages::ContactPage, Pages::OrderPage, Pages::JoinUsPage].each do |model|
      remove_column model.table_name, :content

      model.drop_translation_table!
    end
  end
end
