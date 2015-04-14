# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  # ===================================================
  # modules
  # ===================================================
  include RailsAdminMethods
  #better_include Resource
  include Resource

  # ===================================================
  # plugins
  # ===================================================
  acts_as_taggable

  attr_accessible :tags, :tag_list
  accessible_nested_attributes_for :translations, :portfolio_tag_scope, :static_page_data



  def self.remove_text_align_justify(fields = [])
    fields = [:content] if fields.try(&:empty?)
    ActiveRecord::Base.remove_text_align_justify(self, fields)
  end



  validates :name, :presence => true

  #validates :title, :presence => true, length: { maximum: 70 }

  validates :short_description, :presence => true, length: { maximum: 250 }


  # Paperclip image attachments


  has_attached_file :avatar,
                    styles: proc { |a|
                      a.instance.resolve_avatar_styles
                    },
                    :url  => '/assets/articles/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/articles/:id/:style/:basename.:extension'
  init_paperclip_fields(:avatar)



  def resolve_avatar_styles
    example = {
        thumb: {
            processors: [:thumbnail, :optimizer_paperclip_processor],
            geometry: '250x200#',
            optimizer_paperclip_processor: {  }
        }
    }

    field_name = "avatar"
    content_type = send("#{field_name}_content_type")

    styles = { :thumb => '150x150>', :article_item => '320x320>', home_article_item: '250x250>', article_page: '500x500>'}


    if content_type == "image/jpeg"

    elsif content_type == "image/png"

    end

    styles
  end



  translates :name, :slug, :short_description, :content, :avatar_alt, :versioning => :paper_trail
  accepts_nested_attributes_for :translations


  class Translation
    #attr_accessible :locale, :published, :name, :slug, :short_description, :content, :avatar_alt
    attr_accessible(*attribute_names)

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :name
        field :slug
        field :short_description
        field :content, :ck_editor
        field :avatar_alt
      end
    end
  end


  #after_validation :generate_static_page_data
  after_validation :normalize_slug
  before_save :generate_release_date


  #before_validation :generate_release_date

  def generate_release_date
    #self.short_description ||= 'my_default_short_description'
    #self.release_date ||= self.created_at
    #release_date = Date.yesterday
    self.release_date ||= DateTime.now
  end

  #before_save :detect_rename_avatar




  has_one :static_page_data, :as => :has_static_page_data

  has_one :portfolio_tag_scope, :as => :scope_taggable

  accepts_nested_attributes_for :portfolio_tag_scope, :allow_destroy => true

  before_save do
    if !portfolio_tag_scope
      self.build_portfolio_tag_scope
    end
  end




  accepts_nested_attributes_for :static_page_data, :allow_destroy => true



  after_save :expire_cached_fragments
  after_destroy :expire_cached_fragments


  def expire_cached_fragments
    c = ActionController::Base.new
    I18n.available_locales.each do |locale|
      c.expire_fragment("#{locale}_home_news")
    end
  end 

  rails_admin do
    list do
      field :published
      field :avatar
      field :name
      field :short_description

    end
    show do
      field :published
      field :name
      field :short_description do 
      	label 'краткое описание'
      end
      field :content, :ck_editor do
      	label 'содержание статьи'
      end 
      field :avatar, :paperclip
    end
    edit do
      field :published
      #field :name

      #field :title

      # field :short_description do
      # 	label 'краткое описание'
      # end
      # field :content, :ck_editor do
      # 	label 'содержание статьи'
      # end

      field :translations, :globalize_tabs
      # field :tag_list do
      #   partial 'tag_list_with_suggestions'
      # end
      field :portfolio_tag_scope do
        active true
        label 'теги'
      end

      group :image_data do
        field :avatar, :paperclip
        field :avatar_file_name_fallback
      end

      field :release_date
      field :author
      field :static_page_data
    end
  end
end
