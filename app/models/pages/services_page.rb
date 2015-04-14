class Pages::ServicesPage < ActiveRecord::Base
  include RailsAdminMethods
  include ActiveRecordResourceExpiration

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  #nested_attributes_for :static_page_data
  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes


  has_many :services
  attr_accessible :services

  accepts_nested_attributes_for :services, :allow_destroy => true
  attr_accessible :services_attributes


  #attr_accessible :content

  attr_accessible :intro_text, :footer_text

  translates :intro_text, :footer_text, :versioning => :paper_trail
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :intro_text, :footer_text

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :intro_text
        field :footer_text
      end
    end
  end



  after_save :expire
  def expire
    I18n.available_locales.each do |locale|
      expire_page(url_helpers.send("#{locale}_service_list_path", locale: locale))
      expire_fragment("#{locale}_services_index")
    end
  end


  rails_admin do


    edit do
      field :translations, :globalize_tabs
      field :services
      field :static_page_data
    end


  end
end
