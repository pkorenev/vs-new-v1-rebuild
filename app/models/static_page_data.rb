class StaticPageData < ActiveRecord::Base
  belongs_to :has_static_page_data, :polymorphic => true

  #acts_as_taggable_on :meta_keywords
  #attr_accessible :meta_keyword_list
  attr_accessible :meta_keywords


  attr_accessible :url
  attr_accessible :body_title
  attr_accessible :head_title
  attr_accessible :meta_keywords
  attr_accessible :meta_description

  attr_accessible :has_static_page_data_id
  attr_accessible :has_static_page_data_type

  has_one :sitemap_element

  accepts_nested_attributes_for :sitemap_element, :allow_destroy => true
  attr_accessible :sitemap_element, :sitemap_element_attributes

  translates :head_title, :meta_keywords, :meta_description
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :head_title, :meta_keywords, :meta_description


    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :head_title
        field :meta_keywords
        #field :meta_keyword_list do
        #  partial 'tag_list_with_suggestions'
        #end
        field :meta_description
      end
    end
  end

  before_save :create_sitemap_element
  def create_sitemap_element
    build_sitemap_element if sitemap_element.nil?
  end

  rails_admin do
    edit do
      #field :head_title
      #field :meta_keywords
      #field :meta_keyword_list do
      #  partial 'tag_list_with_suggestions'
      #end
      #field :meta_description
      field :translations, :globalize_tabs

      field :sitemap_element
    end
  end
end
