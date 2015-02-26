# -*- encoding : utf-8 -*-
class Portfolio::Portfolio < ActiveRecord::Base
  attr_accessible   :published, :task, :thanks_to, :description, :release, :name, :title, :portfolio_category_id, :portfolio_banner_id, :portfolio_technology_ids, :developer_ids, :live, :live_eng, :result, :result_eng, :process, :process_eng

  # Association's category, banners, technologies
  belongs_to :portfolio_category
  has_one    :portfolio_banner
  has_many   :portfolio_technologies
  has_many   :developers

  accepts_nested_attributes_for :portfolio_banner, :allow_destroy => true
  attr_accessible :portfolio_banner_attributes

  translates :name, :slug, :task, :result, :process, :live, :description, :thanks_to, :avatar_alt, :versioning => :paper_trail, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

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

  class Translation
    attr_accessible :locale, :published, :name, :slug, :task, :result, :process, :live, :description, :thanks_to, :avatar_alt

    # def published=(value)
    #   self[:published] = value
    # end

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

  # Paperclip image attachments
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

  [:avatar, :thanks_image].each do |paperclip_field_name|
    attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

    attr_accessor "delete_#{paperclip_field_name}".to_sym
  end



  # Validate models
  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true
  validates_associated :portfolio_category

  # Before validate generate friendly url
  before_validation :generate_slug, :generate_title

  def generate_slug
    self.slug ||= name.parameterize
  end

  def generate_title
    self.title ||= name
  end



  attr_accessible :slug





  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  has_one :portfolio_tag_scope, :as => :scope_taggable
  attr_accessible :portfolio_tag_scope
  accepts_nested_attributes_for :portfolio_tag_scope, :allow_destroy => true
  attr_accessible :portfolio_tag_scope_attributes
  before_save do
    if !portfolio_tag_scope
      self.build_portfolio_tag_scope
    end
  end

  rails_admin do


    edit do
      field :greetings
      field :static_page_data
    end


  end

  # Rails admin configuration
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

  # Generating friendly urls for an items
  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end
end
