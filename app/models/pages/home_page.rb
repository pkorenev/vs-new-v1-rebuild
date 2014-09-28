class Pages::HomePage < ActiveRecord::Base
  attr_accessible :greetings

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes


  translates :greetings, :versioning => :paper_trail
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :greetings, :intro_text

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
