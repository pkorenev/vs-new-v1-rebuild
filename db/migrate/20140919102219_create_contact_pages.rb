class CreateContactPages < ActiveRecord::Migration
  def change
    create_table Pages::ContactPage.table_name do |t|
    end

    create_table Pages::OrderPage.table_name do |t|
    end

    create_table Pages::JoinUsPage.table_name do |t|
    end
  end
end
