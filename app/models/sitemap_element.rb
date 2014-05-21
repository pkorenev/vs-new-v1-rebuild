class SitemapElement < ActiveRecord::Base
  belongs_to :static_page_data
  attr_accessible :static_page_data

  attr_accessible :path
  attr_accessible :url
  attr_accessible :changefreq
  attr_accessible :priority
  attr_accessible :lastmod
  attr_accessible :sitemappable_id
  attr_accessible :sitemappable_type




end
