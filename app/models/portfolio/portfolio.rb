# -*- encoding : utf-8 -*-
class Portfolio::Portfolio < ActiveRecord::Base
  attr_accessible   :published, :task, :thanks_to, :thanks_image, :delete_thanks_image, :description, :release, :name, :portfolio_category_id, :portfolio_banner_id, :portfolio_technology_ids, :developer_ids, :live, :live_eng, :result, :result_eng, :process, :process_eng, :avatar, :delete_avatar

  # Association's category, banners, technologies
  belongs_to :portfolio_category
  has_one    :portfolio_banner
  has_many   :portfolio_technologies
  has_many   :developers

  has_attached_file :avatar

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
                    :url  => '/assets/portfolios/:id/:style/:hash.:extension',
                    :hash_secret => ':basename',
                    :path => ':rails_root/public/assets/portfolios/:id/:style/:hash.:extension'

  # add a delete_<asset_name> method:
  attr_accessor :delete_avatar
  before_validation { self.avatar.clear if self.delete_avatar == '1' }



  attr_accessor :delete_thanks_image

  has_attached_file :thanks_image, :styles => { :big => '700x700>', :thumb => '300x300>' },
                                    :url  => '/assets/portfolios/:id/thanks_image/:style/:basename.:extension',
                                    :hash_secret => ':basename',
                                    :path => ':rails_root/public/assets/portfolios/:id/thanks_image/:style/:basename.:extension'

  # Validate models
  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true
  validates_associated :portfolio_category

  # Before validate generate friendly url
  before_validation :generate_slug

  # Rails admin configuration
  rails_admin do
    label 'Портфолио'
    label_plural 'Портфолио'

    list do
      field :name do
        label 'Название'
      end
      field :portfolio_category do
        label 'Тип работы'
      end
      field :avatar do
        label 'Изображение'
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

      field :name do
        label 'Название'
      end

      field :task do
        label 'Задача'
      end

      field :result do
        label 'Результат'
        ckeditor do
          true
        end
      end

      field :process do
        label 'Процесс'
        ckeditor do
          true
        end
      end

      field :live do
        label 'Реальность'
        ckeditor do
          true
        end
      end

      field :avatar do
        label 'Изображение'
        help 'Минимальное расширение изображения должно быть 716х716! Изображение должно быть цветным!'
      end

      field :portfolio_category do
        label 'Категория работы'
      end

      field :portfolio_banner do
        label 'Баннер работы'
      end

      field :description do
        label 'Описание проекта'
        ckeditor true
      end

      field :thanks_to do
        label 'Благодарность'
      end

      field :thanks_image do
        label 'Картинка с благодарностью' 
      end

      field :developers do
        label 'Команда'
      end
      field :portfolio_technologies do
        label 'Технологии'
      end

      field :release do
        label 'Дата выхода работы'
      end

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
