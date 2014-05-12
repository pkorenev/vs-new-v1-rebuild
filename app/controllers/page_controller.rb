#encoding: utf-8
class PageController < ApplicationController
  layout :resolve_layout

  # Index page
  # TODO: Version 1.2
  # Should limited articles, banners, and companys displaes
  def index
    @get_banners ||= Banner.where(published: true)
    @featured_articles ||= Article.limit(3).where(published: true).order('release_date desc')
    @our_clients ||= TrustCompany.all.order('RANDOM()').limit(15)

    @portfolios ||= Portfolio::Portfolio.where(published: true).order('release desc').limit(12)
    @page_data = Pages::HomePage.first
    @static_page_data = @page_data.static_page_data
    @greetings = @page_data.greetings

    @portfolio_technologies = Portfolio::PortfolioTechnology.all

  end

  # About page
  def about
    @our_clients ||= TrustCompany.all.order("RANDOM()")

    @page_data = Pages::AboutPage.first
    @static_page_data = @page_data.static_page_data
    @content = @page_data.content
    @clients_intro = @page_data.clients_intro
    @team_text = @page_data.team_text

    @static_page_data = Pages::AboutPage.first.static_page_data
  end

  # Contact page
  def contact

  end

  # Order us frame
  def order_us
  end

  # Contact us modal
  def contact_modal
  end

  # connect_with_us
  def connect_with_us
  end

  def service
    @get_all_services ||= Service.where(published: true).order('sort_id DESC')

    @page_data = Pages::ServicesPage.first
    @static_page_data = @page_data.static_page_data
  end

  def article
    @articles ||= Article.where(published: true).order('release_date desc')

    @page_data = Pages::ArticlesListPage.first
    @static_page_data = @page_data.static_page_data
  end

  def article_item
    @article ||= Article.find_by_slug(params[:id])
    @related_articles = Article.limit(2)

    @static_page_data = @article.static_page_data
  end

  def articles_by_tags
    @articles = Article.tagged_with([params[:tag]])

    render :template => "page/article"
  end

  private

  def resolve_layout
    case action_name
      when "contact_modal", "order_us", "connect_with_us"
        "contact_layout"
      else
        "application"
    end
  end
end
