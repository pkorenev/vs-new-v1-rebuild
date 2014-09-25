class Portfolio::PortfolioBanner < ActiveRecord::Base
  attr_accessible :description, :name, :portfolio_id, :title, :background, :delete_background

  # Model is a portfolio part and belongs to it
  belongs_to :portfolio

  # Validate content and name
  validates :name, :presence => true
  #validates :description, :presence => true

  attr_accessor :delete_background

  # Paperclip image attachments
  has_attached_file :background,
                    :url  => '/assets/portfolio_banners/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/portfolio_banners/:id/:style/:basename.:extension'

  translates :title, :description
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :title, :description

    def published=(value)
      self[:published] = value
    end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :title, :ck_editor
        field :description, :ck_editor
      end
    end
  end

  rails_admin do
  	edit do
  		field :name do
  			help 'внутреннее имя'
  		end

  		field :translations, :globalize_tabs

  		field :background do
  			label 'фоновая картинка'
  			help 'на всю ширину екрана'
  		end

  		field :portfolio do
  			help 'использовать баннер для указанного проекта'
  		end	
  	end 
  end
end
