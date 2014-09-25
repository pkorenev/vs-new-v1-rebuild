class TranslateTags < ActiveRecord::Migration
  def self.up

    create_table :tag_translations do |t|
      t.string :locale
      t.belongs_to :tag
      t.string :name

    end

    add_index :tag_translations, :tag_id, name: :index_tag_translations_on_tag_id

    add_index :tag_translations, :locale, name: :index_tag_translations_on_locale

    require Rails.root.join('app/models/tag.rb')

    ActsAsTaggableOn::Tag.all.each do |tag|
      translated_locales = tag.translations_by_locale.keys
      I18n.available_locales.each do |locale|
        if !translated_locales.include?(locale)
          translation = tag.class.translation_class.new
          translation.locale = locale
          translation.name = tag.name
          translation.tag_id = tag.id
          translation.save
        end
      end
    end


    # ActsAsTaggableOn::Tag.create_translation_table!({
    #   :name => :string
    # }, {
    #   :migrate_data => true
    # })
  end

  def self.down
    ActsAsTaggableOn::Tag.drop_translation_table! :migrate_data => true
  end
end