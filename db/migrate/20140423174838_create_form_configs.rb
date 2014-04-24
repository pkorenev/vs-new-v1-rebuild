class CreateFormConfigs < ActiveRecord::Migration
  def change
    create_table :form_configs do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
