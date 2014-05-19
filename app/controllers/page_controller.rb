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

    @portfolio_categories = Portfolio::PortfolioCategory.all

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
    @services_intro = @page_data.intro_text
    @services_footer = @page_data.footer_text
  end

  def article
    @articles ||= Article.where(published: true).order('release_date desc')

    @page_data = Pages::ArticlesListPage.first

    if @page_data
      @static_page_data = @page_data.static_page_data
    end
  end

  def get_related_articles(article)
    articles = Article.where("id <> #{article.id}").order('release_date desc')
    tags = article.tag_list
    related_article_ids = []
    articles.each do | a |
      similar_tags = 0
      tags.each do | t |
        if a.tag_list.include? t
          similar_tags += 1
        end
      end

      #if similar_tags > 0
      related_article_ids.push( { article_id: a.id, similar_tags_count: similar_tags, release_date: a.release_date } )
      #end
    end

    # sort by similar_tags_count
    sorted_related_article_ids = related_article_ids.sort do | x, y |
      similar_tags_count_difference = y[:similar_tags_count] - x[:similar_tags_count]
      res = 0
      if similar_tags_count_difference != 0
        res = similar_tags_count_difference
      else
        if x[:release_date] > y[:release_date]
          res = -1
        elsif x[:release_date] < y[:release_date]
          res = 1
        else
          res = 0
        end
      end

      res

    end

    related_ids = sorted_related_article_ids.take(2)
    related_articles = []
    related_ids.each do | a |
      related_articles.push( Article.find(a[:article_id]) )
    end

    return related_articles
  end

  def article_item
    @article ||= Article.find_by_slug(params[:id])

    @static_page_data = @article.static_page_data



    @related_articles = get_related_articles(@article)
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
