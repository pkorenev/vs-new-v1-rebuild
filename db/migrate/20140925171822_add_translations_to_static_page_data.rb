class AddTranslationsToStaticPageData < ActiveRecord::Migration
  def up
    model = StaticPageData
    if model.respond_to?(:translates?) && model.translates?
      model.create_translation_table!

      model.all.each  {|item| translated_locales = item.translations_by_locale.keys; I18n.available_locales.each {|locale| if !translated_locales.include?(locale) then; t = model.translation_class.new; id_method_name = "static_page_datum_id="; t.send(id_method_name, item.id); t.locale = locale; item.translated_attribute_names.each {|attr_name|   t.send("#{attr_name}=", item.send(attr_name) );  };  t.save;  end;  } }
    end

  end

  def down
    model = StaticPageData
    if model.respond_to?(:translates?) && model.translates?
      model.drop_translation_table!
    end
  end
end
