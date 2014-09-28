class AddTranslationsToModels < ActiveRecord::Migration
  def up
    [Pages::PortfolioListPage, Pages::HomePage, Pages::ServicesPage].each do |model|
      model.create_translation_table!

      column_names = []
      columns = ActiveRecord::Base.connection.columns(model.table_name)
      columns.each do |c|
        column_names.push(c.name.to_sym)
      end


      change_table model.table_name do |t|

        t.boolean :published if  !column_names.include?(:published)
      end

      change_table model.translation_class.table_name do |t|
        t.boolean :published
      end

      model.all.each  {|item|
        translated_locales = item.translations_by_locale.keys;
        I18n.available_locales.each {|locale|
          if !translated_locales.include?(locale) then;
          t = model.translation_class.new;
          t.send("#{model.to_s.remove('::').underscore}_id=", item.id);
          t.locale = locale; item.translated_attribute_names.each {|attr_name|
            t.send("#{attr_name}=", item.send(attr_name) );
          };
          item.published = true
          t.published = item.published if locale.to_sym == :uk;
          t.save;
          end;
        }
      }
    end


  end

  def down
    [Pages::PortfolioListPage, Pages::HomePage, Pages::ServicesPage].each do |model|
      model.drop_translation_table!

      remove_column model.table_name, :published

    end
  end
end
