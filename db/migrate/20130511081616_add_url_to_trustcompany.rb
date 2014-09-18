class AddUrlToTrustcompany < ActiveRecord::Migration
  def change
    add_column :trust_companies, :url, :string
  end
end
