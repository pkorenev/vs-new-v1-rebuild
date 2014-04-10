class PortfolioController < ApplicationController
  def index
    @portfolios ||= Portfolio::Portfolio.all
  end

  def item
    # Fetching Portfolio Web item
    #@item ||= Portfolio::Portfolio.where('slug = "'+params[:item]+'"')
    @item = Portfolio::Portfolio.find_by_slug!(params[:item])
    @other_projects = Portfolio::Portfolio.where('slug != "'+params[:item]+'"').limit(8)
  end

  def category

  end

  def polygraphy
    @polygraphy ||= Portfolio::Portfolio.find_all_by_portfolio_category_id(1)
  end

  def polygraphy_item
    @polygraphy_item ||= Portfolio::Portfolio.find_by_slug!(params[:id])
  end

  def corporate_identity
    # Fetching all works in corporate identity portfolio section
    @corporate_identity ||= Portfolio::Portfolio.find_all_by_portfolio_category_id(2)
  end

  def corporate_identity_item
    # Fetching corporate identity item
    @corporate_identity_item ||= Portfolio::Portfolio.find_by_slug!(params[:id])
  end

  def web
    # Fetching all works in web portfolio sections
    @web ||= Portfolio::Portfolio.find_all_by_portfolio_category_id(3)
  end

  def web_item
    # Fetching Portfolio Web item
    @web_item ||= Portfolio::Portfolio.where('slug = "'+params[:id]+'"')
    @other_projects = Portfolio::Portfolio.where('slug != "'+params[:id]+'"').limit(8)
  end

end
