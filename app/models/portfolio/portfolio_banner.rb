class Portfolio::PortfolioBanner < ActiveRecord::Base
  attr_accessible :description, :name, :portfolio_id, :title

  # Model is a portfolio part and belongs to it
  belongs_to :portfolio

  # Validate content and name
  validates :name, :presence => true
  #validates :description, :presence => true


  # Paperclip image attachments
  has_attached_file :background,
                    :url  => '/assets/portfolio_banners/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/portfolio_banners/:id/:style/:basename.:extension'

  [:background].each do |paperclip_field_name|
    attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

    attr_accessor "delete_#{paperclip_field_name}".to_sym
  end

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


      group :image_data do
        field :background do
          label 'фоновая картинка'
          help 'на всю ширину екрана'
        end
        field :background_file_name_fallback
      end


  		field :portfolio do
  			help 'использовать баннер для указанного проекта'
  		end	
  	end 
  end
end
