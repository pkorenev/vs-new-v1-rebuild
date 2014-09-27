class CreateCustomArticles < ActiveRecord::Migration
  def up
    model = CustomArticle
    create_table model.table_name do |t|
      t.string :name
      t.string :slug
      t.text :short_description
      t.text :full_description

      t.boolean :published

      t.has_attached_file :avatar
      t.string :avatar_file_name_fallback
      t.string :avatar_alt

      t.timestamps
    end

    model.create_translation_table!

    change_table model.translation_class.table_name do |t|
      t.boolean :published
    end

  end

  def down
    model = CustomArticle
    drop_table model.table_name
    model.drop_translation_table!
  end
end
