class CreateDictionaries < ActiveRecord::Migration
  def up
    model = Dictionary
    create_table model.table_name do |t|
      t.string :name
      t.string :code_name
      t.text :info_description

      t.timestamps
    end
  end

  def down
    model = Dictionary

    drop_table model.table_name
  end
end
