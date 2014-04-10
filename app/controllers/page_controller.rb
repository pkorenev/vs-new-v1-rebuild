#encoding: utf-8
class PageController < ApplicationController
  layout :resolve_layout

  # Index page
  # TODO: Version 1.2
  # Should limited articles, banners, and companys displaes
  def index
    @get_banners ||= Banner.find_all_by_published(:t)
    @featured_articles ||= Article.limit(3).find_all_by_published(:t)
    @our_clients ||= TrustCompany.find(:all, :order => "RANDOM()", :limit => 15)

    @portfolios ||= Portfolio::Portfolio.where(published: true).order('release desc').limit(12)


  end

  # About page
  def about
    @our_clients ||= TrustCompany.find(:all, :order => "RANDOM()")
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
    @get_all_services ||= Service.order('sort_id DESC').find_all_by_published(:t)
  end

  def article
    @articles ||= Article.order('id desc').find_all_by_published(:t)
  end

  def article_item
    @article ||= Article.find_by_slug(params[:id])
    @related_articles = Article.limit(2)
  end

  def articles_by_tags
    @articles = Article.tagged_with([params[:tag]])

    render :template => "page/article"
  end

  private

  def resolve_layout
    case action_name
      when "contact_modal", "order_us", "connect_with_us"
        "contact-layout"
      else
        "application"
    end
  end
end
