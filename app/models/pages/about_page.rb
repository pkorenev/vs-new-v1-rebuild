class Pages::AboutPage < ActiveRecord::Base
  include RailsAdminMethods
  include ActiveRecordResourceExpiration

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  #nested_attributes_for :static_page_data
  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  attr_accessible :content
  attr_accessible :clients_intro
  attr_accessible :team_text



  translates :content, :clients_intro, :team_text, :versioning => :paper_trail
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :content, :clients_intro, :team_text

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :content
        field :clients_intro
        field :team_text
      end
    end
  end


  after_save :expire
  def expire
    I18n.available_locales.each do |locale|
      expire_fragment("#{locale}_about_top_content")
      expire_fragment("#{locale}_about_bottom_content")

      expire_page(url_helpers.send("#{locale}_about_path", locale: locale))
    end
  end




  rails_admin do
    #field :content
    #field :clients_intro
    #field :team_text
    field :translations, :globalize_tabs

    field :static_page_data
  end
end
