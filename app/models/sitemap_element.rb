class SitemapElement < ActiveRecord::Base
  belongs_to :static_page_data
  attr_accessible :static_page_data, :static_page_data_id

  attr_accessible :path
  attr_accessible :url
  attr_accessible :changefreq
  attr_accessible :priority
  attr_accessible :lastmod
  attr_accessible :sitemappable_id
  attr_accessible :sitemappable_type




  rails_admin do
    edit do
      field :path
      field :url do
        read_only true
      end
      field :changefreq
      field :priority
      field :lastmod
    end
  end


end
