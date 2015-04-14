# -*- encoding : utf-8 -*-
class Portfolio::Portfolio < ActiveRecord::Base
  # ===================================================
  # modules
  # ===================================================
  include RailsAdminMethods
  include Resource

  # ===================================================
  # plugins
  # ===================================================
  acts_as_taggable
  my_translates :name, :slug, :task, :result, :process, :live, :description, :thanks_to, :avatar_alt, :versioning => :paper_trail, :fallbacks_for_empty_translations => true
  has_seo_tags

  # ===================================================
  # associations
  # ===================================================
  has_one :portfolio_tag_scope, :as => :scope_taggable
  accessible_nested_attributes_for :portfolio_tag_scope, :allow_destroy => true

  belongs_to :portfolio_category

  has_one    :portfolio_banner
  accessible_nested_attributes_for :portfolio_banner, :allow_destroy => true

  has_many   :portfolio_technologies
  has_many   :developers



  # ===================================================
  # attachments
  # ===================================================

  has_attached_file :avatar, :styles => {
                               admin_prv:     '65x65#',
                               thumb_bw:      '100x100#',
                               non_retina_bw: '360x360#',
                               retina_bw:     '716x716#',
                               non_retina:    '360x360#',
                               retina:        '716x716#',
                               thumb180:      '180x180>'
                           },
                    :processor => 'mini_magick',
                    :convert_options => {
                        thumb_bw: '-threshold 50%',
                        non_retina_bw: '-threshold 50%',
                        retina_bw: '-threshold 50%'
                    },
                    :url  => '/assets/portfolios/:id/:style/:basename.:extension',
                    :hash_secret => ':basename',
                    :path => ':rails_root/public/assets/portfolios/:id/:style/:basename.:extension'

  # add a delete_<asset_name> method:
  has_attached_file :thanks_image, :styles => { :big => '700x700>', :thumb => '300x300>' },
                    :url  => '/assets/portfolios/:id/thanks_image/:style/:basename.:extension',
                    :hash_secret => ':basename',
                    :path => ':rails_root/public/assets/portfolios/:id/thanks_image/:style/:basename.:extension'

  # ===================================================
  # Additional attr_accessible
  # ===================================================
  attr_accessible :tags, :tag_list

  # ===================================================
  # Validations
  # ===================================================
  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true
  validates_associated :portfolio_category

  # ===================================================
  # ActiveRecord Callbacks
  # ===================================================
  before_validation :generate_slug, :generate_title
  before_save :normalize_tag_scope
  after_save :expire_cached_fragments
  after_destroy :expire_cached_fragments

  # ===============================================
  # -----------------------------------------------
  # Methods
  # -----------------------------------------------
  # ===============================================

  def normalize_tag_scope
    if portfolio_tag_scope.nil?
      self.build_portfolio_tag_scope
    end
  end

  # Generating friendly urls for an items
  def to_param
    slug
  end

  def self.remove_text_align_justify(fields = [])
    fields = [:live, :result, :process] if fields.try(&:empty?)
    ActiveRecord::Base.remove_text_align_justify(self, fields)
  end

  def published_locales
    locales = []
    published_translations.each do |t|
      locales.push(t.locale.to_sym)
    end

    locales
  end

  def published_translations
    translations.where(published: true)
  end

  def expire_cached_fragments
  	c = ActionController::Base.new
  	I18n.available_locales.each do |locale|
  		c.expire_fragment("#{locale}_home_portfolio")
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
        field :task
        field :result, :ck_editor
        field :process, :ck_editor
        field :live, :ck_editor
        field :description, :ck_editor
        field :thanks_to
        field :avatar_alt
      end
    end
  end

  rails_admin do
    # label 'Портфолио'
    # label_plural 'Портфолио'

    list do
      field :name do
        #label 'Название'
      end
      field :portfolio_category do
        #label 'Тип работы'
      end
      field :avatar do
        #label 'Изображение'
        thumb_method :admin_prv
      end
    end

    show do
      field :name
      field :portfolio_category
    end

    edit do

      field :published do
        label 'Опубликовать'
      end
      #
      # field :name do
      #   label 'Название (внутреннее)'
      # end
      #



      # field :title do
      #   #label 'Название'
      # end

      field :translations, :globalize_tabs
      #
      # field :slug do
      #   label 'url портфолио относительно категории'
      # end
      #
      # field :task do
      #   label 'Задача'
      # end
      #
      # field :result, :ck_editor do
      #   label 'Результат'
      # end
      #
      # field :process, :ck_editor do
      #   label 'Процесс'
      # end
      #
      # field :live, :ck_editor do
      #   label 'Реальность'
      # end

      group :avatar_image_data do
        field :avatar do
          label 'Изображение'
          help 'Минимальное расширение изображения должно быть 716х716! Изображение должно быть цветным!'
        end

        field :avatar_file_name_fallback
      end

      field :portfolio_category do
        label 'Категория работы'
      end

      field :portfolio_banner do
        label 'Баннер работы'
      end

      # field :description, :ck_editor do
      #   label 'Описание проекта'
      # end
      #
      # field :thanks_to do
      #   label 'Благодарность'
      # end


      group :thanks_image_data do

        field :thanks_image do
        #  label 'Картинка с благодарностью'
        end

        field :thanks_image_file_name_fallback
      end

      field :portfolio_tag_scope do
        active true
        label 'теги'
      end

      field :developers do
       # label 'Команда'
      end

      field :portfolio_technologies do
       # label 'Технологии'
      end

      field :release do
      #  label 'Дата выхода работы'
      end

      field :static_page_data

    end

  end
end
