class Portfolio::PortfolioCategory < ActiveRecord::Base
  attr_accessible :name, :title, :slug, :short_description , :full_description, :portfolio_ids

  has_many :portfolios

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  translates :name, :slug, :short_description , :full_description, :versioning => :paper_trail
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :name, :slug, :short_description , :full_description

    def published=(value)
      self[:published] = value
    end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :name
        field :slug
        #field :short_description
        field :full_description
      end
    end
  end

  before_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  rails_admin do
    edit do
      field :translations, :globalize_tabs
      field :static_page_data
      # field :name do
      #   label 'внутренне имя'
      # end
      # field :title do
      #   label 'Title (имя)'
      # end
      # field :slug do
      #   label 'url категории'
      # end
    end
  end
end
