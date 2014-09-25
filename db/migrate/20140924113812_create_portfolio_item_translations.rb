class CreatePortfolioItemTranslations < ActiveRecord::Migration
  def up
    model = Portfolio::Portfolio

    change_table model.table_name do |t|
      t.string :avatar_alt
    end
    if model.respond_to?(:translates?) && model.translates?
      model.create_translation_table!
      change_table model.translation_class.table_name do |t|
        t.boolean :published
      end
    end

    model.all.each  {|item| translated_locales = item.translations_by_locale.keys; I18n.available_locales.each {|locale| if !translated_locales.include?(locale) then; t = model.translation_class.new; t.send("#{model.to_s.split('::').last.underscore}_id=", item.id); t.locale = locale; item.translated_attribute_names.each {|attr_name|   t.send("#{attr_name}=", item.send(attr_name) );  }; t.published = item.published if locale.to_sym == :uk; t.save;  end;  } }
  end

  def down
    model = Portfolio::Portfolio

    remove_column model.table_name, :avatar_alt

    model.drop_translation_table!
  end
end