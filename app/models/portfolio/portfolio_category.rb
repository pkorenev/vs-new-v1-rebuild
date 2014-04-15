class Portfolio::PortfolioCategory < ActiveRecord::Base
  attr_accessible :name, :portfolio_ids

  has_many :portfolios

  validates :name, presence: true
  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  rails_admin do
    edit do
      field :name
      field :slug do
        label 'url категории'
      end
    end
  end
end
