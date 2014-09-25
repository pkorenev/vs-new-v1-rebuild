class AddTranslationsToSitemapElements < ActiveRecord::Migration
  def up
    model = SitemapElement
    if model.respond_to?(:translates?) && model.translates?
      model.create_translation_table!

      change_table model.translation_class.table_name do |t|
        t.float :priority
        t.datetime :lastmod
        t.boolean :display_on_sitemap
      end

      model.all.each  {|item| translated_locales = item.translations_by_locale.keys; I18n.available_locales.each {|locale| if !translated_locales.include?(locale) then; t = model.translation_class.new; t.send("#{model.to_s.split('::').last.underscore}_id=", item.id); t.locale = locale; item.translated_attribute_names.each {|attr_name|   t.send("#{attr_name}=", item.send(attr_name) );  }; t.display_on_sitemap = item.display_on_sitemap if locale.to_sym == :uk; t.priority = item.priority; t.lastmod = item.lastmod; t.save;  end;  } }
    end

  end

  def down
    model = SitemapElement
    if model.respond_to?(:translates?) && model.translates?
      model.drop_translation_table!
    end
  end
end
