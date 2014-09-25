class AddTranslationToModels < ActiveRecord::Migration
  def up
    Service.create_translation_table!


  end

  def down
    Service.drop_translation_table!
  end
end
