# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  # ===================================================
  # modules
  # ===================================================
  include RailsAdminMethods
  include Resource


  # ===================================================
  # plugins
  # ===================================================
  acts_as_taggable
  my_translates :name, :slug, :short_description, :content, :avatar_alt, :versioning => :paper_trail
  has_seo_tags

  # ===================================================
  # associations
  # ===================================================
  has_one :portfolio_tag_scope, :as => :scope_taggable
  accessible_nested_attributes_for :portfolio_tag_scope, :allow_destroy => true

  # ===================================================
  # attachments
  # ===================================================

  # Paperclip image attachments
  has_paperclip_attached_file :avatar,
    styles: proc { |a|
      a.instance.resolve_avatar_styles
    },
    :url  => '/assets/articles/:id/:style/:basename.:extension',
    :path => ':rails_root/public/:url'

  # ===================================================
  # Additional attr_accessible
  # ===================================================
  attr_accessible :tags, :tag_list

  # ===================================================
  # Validations
  # ===================================================

  validates :name, :presence => true

  #validates :title, :presence => true, length: { maximum: 70 }

  validates :short_description, :presence => true, length: { maximum: 250 }

  # ===================================================
  # ActiveRecord Callbacks
  # ===================================================
  before_save :normalize_tag_scope
  after_save :expire
  after_destroy :expire

  # ===============================================
  # -----------------------------------------------
  # Methods
  # -----------------------------------------------
  # ===============================================

  def resolve_avatar_styles
    styles = {
        thumb: {
            processors: [:thumbnail, :optimizer_paperclip_processor],
            geometry: '320x320>',
            optimizer_paperclip_processor: {  }
        },
        item: {
            processors: [:thumbnail, :optimizer_paperclip_processor],
            geometry: '800x500>',
            optimizer_paperclip_processor: {  }
        }
    }

    styles
  end

  def normalize_tag_scope
    if portfolio_tag_scope.nil?
      self.build_portfolio_tag_scope
    end
  end

  def expire
    I18n.available_locales.each do |locale|
      expire_fragment("#{locale}_home_news")
    end
  end


  # ===============================================
  # -----------------------------------------------
  # Rails admin config
  # -----------------------------------------------
  # ===============================================

  # class Translation
  #   rails_admin do
  #     edit do
  #       field :locale, :hidden
  #       field :published
  #       field :name
  #       field :slug
  #       field :short_description
  #       field :content, :ck_editor
  #       field :avatar_alt
  #     end
  #   end
  # end

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
