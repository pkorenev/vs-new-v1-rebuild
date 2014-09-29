class AddTranslationsToModels < ActiveRecord::Migration
  def up
    [Pages::PortfolioListPage, Pages::AboutPage, Pages::ContactPage, Pages::HomePage, Pages::JoinUsPage, Pages::OrderPage, Pages::ServicesPage].each do |model|
      column_names = []
      columns = ActiveRecord::Base.connection.columns(model.table_name)
      columns.each do |c|
        column_names.push(c.name.to_sym)
      end
      change_table model.table_name do |t|
        t.boolean :published if  !column_names.include?(:published)
      end

      if model.respond_to?(:translates?) && model.translates?
        if !ActiveRecord::Base.connection.tables.include?(model.translation_class.table_name)
          model.create_translation_table!
        end





        change_table model.translation_class.table_name do |t|
          t.boolean :published
        end

        model.all.each  {|item|
          translated_locales = item.translations_by_locale.keys;
          I18n.available_locales.each {|locale|
            if !translated_locales.include?(locale) then;
            t = model.translation_class.new;
            model_id_column_name = "#{model.table_name.sub(/^#{model.table_name_prefix}/, '').singularize}_id"
            t.send("#{model_id_column_name}=", item.id);
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
  end

  def down
    [Pages::PortfolioListPage, Pages::AboutPage, Pages::ContactPage, Pages::HomePage, Pages::JoinUsPage, Pages::OrderPage, Pages::ServicesPage].each do |model|

      if model.respond_to?(:translates?) && model.translates?
        if ActiveRecord::Base.connection.tables.include?(model.translation_class.table_name)
          model.drop_translation_table!
        end
      end

      remove_column model.table_name, :published

    end
  end
end
