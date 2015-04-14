# -*- encoding : utf-8 -*-
class Service < ActiveRecord::Base
  # ===================================================
  # modules
  # ===================================================
  include RailsAdminMethods
  include Resource

  # ===================================================
  # plugins
  # ===================================================
  acts_as_taggable
  #my_translates :name, :slug, :short_description, :content, :avatar_alt, :versioning => :paper_trail
  my_translates :short_description, :full_description, :avatar_alt, :slug, :name, :versioning => :paper_trail
  has_seo_tags
  has_paper_trail

  # ===================================================
  # associations
  # ===================================================
  has_one :portfolio_tag_scope, :as => :scope_taggable
  accessible_nested_attributes_for :portfolio_tag_scope, :allow_destroy => true

  belongs_to :services_page, :class_name => 'Pages::ServicesPage'
  attr_accessible :services_page, :services_page_id

  # ===================================================
  # attachments
  # ===================================================
  has_paperclip_attached_file :avatar,
    styles: proc {|a| a.instance.resolve_avatar_styles }

  # ===================================================
  # Additional attr_accessible
  # ===================================================
  attr_accessible :tags, :tag_list

  # ===================================================
  # Validations
  # ===================================================
  validates :sort_id, :uniqueness => true, :presence => true

  # ===================================================
  # ActiveRecord Callbacks
  # ===================================================
  before_save :normalize_tag_scope
  #after_save :expire_cached_fragments
  #after_destroy :expire_cached_fragments
  # before_validation :generate_slug
  # before_validation :generate_name
  before_validation :configure_sort_id

  # ===============================================
  # -----------------------------------------------
  # Methods
  # -----------------------------------------------
  # ===============================================

  def configure_sort_id
    sort_id ||= id
  end

  def normalize_tag_scope
    if portfolio_tag_scope.nil?
      self.build_portfolio_tag_scope
    end
  end

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

  def expire
    I18n.available_locales.each do |locale|
      Pages::ServicesPage.first.expire
      expire_page(url_helpers.send("#{locale}_service_item", locale: locale, format: "html", service_item: translations_by_locale[locale].slug))
    end
  end






  # ===============================================
  # -----------------------------------------------
  # Rails admin config
  # -----------------------------------------------
  # ===============================================

  class Translation
    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :name
        field :slug
        field :short_description
        field :full_description, :ck_editor
        field :avatar_alt
      end
    end
  end

  rails_admin do
    configure :sort_id do
      label 'Порядок сортировки на странице вывода всех сервисов'
    end

    configure :published do
      label 'опубликовать'
    end

    configure :avatar_file_name_fallback do
      label 'имя файла'
      help 'должен включать расширение. Например: gav-upakovka.jpg'
    end

    configure :static_page_data do
      label 'Данные о странице'
    end

    configure :services_page do

    end

   list do
   field :sort_id do
     #label 'id'
    end
    field :published
    field :name
    field :short_description
    field :avatar
   end

   edit do
    field :sort_id do
     label ''

    end
    field :published

    field :translations, :globalize_tabs

    field :portfolio_tag_scope do
      active true
      label 'теги'
    end

    group :image_data do
      field :avatar
      field :avatar_file_name_fallback do

        label 'file name'
      end
    end
     field :services_page

    field :static_page_data


   end
  end
end


