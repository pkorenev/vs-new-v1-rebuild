class StaticPageData < ActiveRecord::Base
  belongs_to :has_static_page_data, :polymorphic => true

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
      field :meta_keywords
      field :meta_description
    end
  end
end
