class SitemapElement < ActiveRecord::Base
  include RailsAdminMethods
  belongs_to :static_page_data
  attr_accessible :static_page_data, :static_page_data_id

  attr_accessible :display_on_sitemap
  attr_accessible :path
  attr_accessible :url
  attr_accessible :changefreq
  attr_accessible :priority
  attr_accessible :lastmod
  attr_accessible :sitemappable_id
  attr_accessible :sitemappable_type


  #before_save :set_url, :set_defaults
  def set_url
    self.url = "http://#{ActionMailer::Base.default_url_options[:host]}#{ self.path }"
  end

  def set_defaults
    self.display_on_sitemap ||= true
    self.changefreq ||= :weekly
    self.priority ||= 0.8
  end

  def resource
    static_page_data.try(&:has_static_page_data) 
  end  

  validates :path,presence: true, uniqueness: true

  translates :path, :url, :changefreq
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :display_on_sitemap, :path, :url, :changefreq, :priority, :lastmod

    before_save :set_url, :set_defaults
    def set_url
      self.url = "http://#{ActionMailer::Base.default_url_options[:host]}#{ self.path }"
    end

    def set_defaults
      self.display_on_sitemap ||= true
      self.changefreq ||= :weekly
      self.priority ||= 0.8
    end

    validates :path, presence: true, uniqueness: true

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        # field :published
        # field :name
        # field :slug
        # field :short_description
        # field :content, :ck_editor
        # field :avatar_alt

        field :display_on_sitemap
        field :path
        field :url do
          read_only true
        end
        field :changefreq, :enum do
          enum do
            [ :always, :hourly, :daily, :weekly, :monthly, :yearly]
          end
        end
        field :priority
        field :lastmod
      end
    end
  end



  rails_admin do
    edit do
      field :resource do
        partial "sitemap_resource"
      end  
      field :translations, :globalize_tabs
    end

    nested do
      field :translations, :globalize_tabs
    end  
  end


end
