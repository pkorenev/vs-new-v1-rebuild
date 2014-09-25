class Portfolio::PortfolioCategory < ActiveRecord::Base
  attr_accessible :name, :title, :slug, :portfolio_ids

  has_many :portfolios

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  translates :name, :slug
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :name, :slug

    def published=(value)
      self[:published] = value
    end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :name
        field :slug
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
