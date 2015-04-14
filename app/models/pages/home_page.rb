require "render_anywhere"
class Pages::HomePage < ActiveRecord::Base
  include RailsAdminMethods
  include RenderAnywhere
  include ActiveRecordResourceExpiration

  attr_accessible :greetings

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes


  after_save :expire
  def expire
    I18n.available_locales.each do |locale|
      expire_page(url_helpers.root_path(locale: locale))
    end
  end

  translates :greetings, :versioning => :paper_trail
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :greetings

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :greetings
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
