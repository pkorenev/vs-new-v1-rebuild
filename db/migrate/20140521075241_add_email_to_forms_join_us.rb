class AddEmailToFormsJoinUs < ActiveRecord::Migration
  def change
    add_column :forms_join_us, :email, :string
  end
end
