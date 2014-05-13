class Portfolio::PortfolioCategory < ActiveRecord::Base
  attr_accessible :name, :title, :url, :portfolio_ids

  has_many :portfolios

  validates :name, presence: true
  validates :url, uniqueness: true, presence: true

  before_validation :generate_url

  def to_param
    url
  end

  def generate_url
    self.url ||= name.parameterize
  end

  rails_admin do
    edit do
      field :name do
        label 'внутренне имя'
      end
      field :title do
        label 'Title (имя)'
      end
      field :url do
        label 'url категории'
      end
    end
  end
end
