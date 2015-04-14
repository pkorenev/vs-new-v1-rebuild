class Pages::PortfolioListPage < ActiveRecord::Base
  include RailsAdminMethods
  include ActiveRecordResourceExpiration

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  attr_accessible :intro_text


  after_save :expire
  def expire
    I18n.available_locales.each do |locale|
      expire_page(url_helpers.send("#{locale}_portfolio_path", locale: locale))
    end
  end

  translates :intro_text, :versioning => :paper_trail
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :intro_text

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :intro_text, :ck_editor

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
