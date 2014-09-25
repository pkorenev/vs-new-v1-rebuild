class CreateRoutes < ActiveRecord::Migration
  def up
    create_table Route.table_name do |t|
      t.string :name
      t.string :route_string
      t.string :route_name
      t.string :controller_action
      t.string :redirect_to_url
      t.integer :position

      t.timestamps
    end

    add_index Route.table_name, :position

    Route.create_translation_table!
  end

  def down
    remove_index Route.table_name, :position

    drop_table Route.table_name

    Route.drop_translation_table!
  end
end
