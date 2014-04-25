class StaticPageData < ActiveRecord::Base
  belongs_to :has_static_page_data, :polymorphic => true

  acts_as_taggable_on :meta_keywords
  attr_accessible :meta_keyword_list

  attr_accessible :url
  attr_accessible :body_title
  attr_accessible :head_title
  attr_accessible :meta_keywords
  attr_accessible :meta_description

  attr_accessible :has_static_page_data_id
  attr_accessible :has_static_page_data_type

  rails_admin do
    edit do
      field :head_title
      #field :meta_keywords
      field :meta_keyword_list do
        partial 'tag_list_with_suggestions'
      end
      field :meta_description
    end
  end
end
