class Pages::ContactPage < ActiveRecord::Base
  include RailsAdminMethods
  include ActiveRecordResourceExpiration

  self.table_name = :page_contact_page

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  attr_accessible :content

  translates :content
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  after_save :expire
  def expire
    I18n.available_locales.each do |locale|
      expire_page(url_helpers.send("#{locale}_contact_path", locale: locale, format: "html"))
    end
  end

  class Translation
    attr_accessible :locale, :content

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :content, :ck_editor
      end
    end
  end

  rails_admin do


    edit do
      field :translations, :globalize_tabs
      field :static_page_data
    end


  end
end
