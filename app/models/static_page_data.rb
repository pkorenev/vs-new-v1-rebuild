class StaticPageData < ActiveRecord::Base
  belongs_to :has_static_page_data, :polymorphic => true
end
