class Portfolio::PortfolioBanner < ActiveRecord::Base
  # ===================================================
  # modules
  # ===================================================
  include RailsAdminMethods
  include Resource

  # ===================================================
  # plugins
  # ===================================================
  my_translates :title, :description, :versioning => :paper_trail

  # ===================================================
  # associations
  # ===================================================

  # Model is a portfolio part and belongs to it
  belongs_to :portfolio

  # ===================================================
  # attachments
  # ===================================================
  has_paperclip_attached_file :background,
    styles: proc { |a| a.instance.resolve_background_styles },
    url: '/assets/portfolio_banners/:id/:style/:basename.:extension',
    path: ':rails_root/public/:url'

  # ===================================================
  # Additional attr_accessible
  # ===================================================

  # ===================================================
  # Validations
  # ===================================================
  validates :name, :presence => true
  #validates :description, :presence => true

  # ===================================================
  # ActiveRecord Callbacks
  # ===================================================

  # ===============================================
  # -----------------------------------------------
  # Methods
  # -----------------------------------------------
  # ===============================================

  def resolve_background_styles
    styles = {
        full_width: {
            processors: [:thumbnail, :optimizer_paperclip_processor],
            geometry: '1980x420#',
            optimizer_paperclip_processor: {  }
        }
    }

    styles
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
        field :title, :ck_editor
        field :description, :ck_editor
      end
    end
  end

  rails_admin do
  	edit do
      field :published

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
