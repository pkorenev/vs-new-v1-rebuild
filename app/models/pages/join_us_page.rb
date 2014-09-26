class Pages::JoinUsPage < ActiveRecord::Base
  self.table_name = :page_join_us_page

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  attr_accessible :content

  translates :content
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :content

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :translations, :globalize_tabs
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
