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
  attr_accessible :sitemap_element

  before_save :create_sitemap_element
  def create_sitemap_element
    build_sitemap_element
  end

  rails_admin do
    edit do
      field :head_title
      field :meta_keywords
      #field :meta_keyword_list do
      #  partial 'tag_list_with_suggestions'
      #end
      field :meta_description

      field :sitemap_element
    end
  end
end
