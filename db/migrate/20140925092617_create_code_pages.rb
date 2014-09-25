class CreateCodePages < ActiveRecord::Migration
  def change
    create_table :code_pages do |t|
      t.text :code
      t.string :file_path

      t.timestamps
    end
  end
end
