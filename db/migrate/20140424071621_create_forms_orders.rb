class CreateFormsOrders < ActiveRecord::Migration
  def change
    create_table :forms_orders do |t|
      t.string :name
      t.string :phone
      t.string :organization_name
      t.string :email
      t.string :money
      t.text :text

      t.timestamps
    end
  end
end
