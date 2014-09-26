class CreateDictionaryKeys < ActiveRecord::Migration
  def up
    model = DictionaryKey
    create_table model.table_name do |t|
      t.text :key
      t.text :value
      t.text :info_description
      t.belongs_to :dictionary

      t.timestamps
    end

    model.create_translation_table!
  end

  def down
    model = DictionaryKey

    drop_table model.table_name

    model.drop_translation_table!
  end
end
