class Pages::ArticlesListPage < ActiveRecord::Base
  include RailsAdminMethods
  include ActiveRecordResourceExpiration

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  after_save :expire
  def expire
    I18n.available_locales.each do |locale|
      expire_page(url_helpers.send("#{locale}_article_list_path", locale: locale, format: "html"))
    end
  end

  rails_admin do


    edit do
      field :static_page_data
    end


  end
end
