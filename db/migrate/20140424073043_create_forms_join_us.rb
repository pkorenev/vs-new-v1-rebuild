class CreateFormsJoinUs < ActiveRecord::Migration
  def change
    create_table :forms_join_us do |t|
      t.string :name
      t.string :phone
      t.has_attached_file :portfolio
      t.string :role
      t.string :text

      t.timestamps
    end
  end
end
