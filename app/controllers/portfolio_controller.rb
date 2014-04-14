class PortfolioController < ApplicationController
  def index
    @portfolios ||= Portfolio::Portfolio.all
  end

  def item
    # Fetching Portfolio Web item
    #@item ||= Portfolio::Portfolio.where('slug = "'+params[:item]+'"')
    @item = Portfolio::Portfolio.where(slug: params[:item]).limit(1)
    if @item.count == 1
      @item = @item.first
    end
    @other_projects = Portfolio::Portfolio.where('slug != "'+params[:item]+'"').limit(8)

    #portfolio_count = Portfolio::Portfolio.count
    @next_portfolio = Portfolio::Portfolio.first
    @prev_portfolio = Portfolio::Portfolio.first

    if @item

      query = "SELECT p.id FROM portfolios p ORDER BY p.portfolio_category_id, p.release asc"
      result = ActiveRecord::Base.connection.execute(query)
      arr_ids = []
      result.each do | row |
        arr_ids.push( row['id'] )
      end

      current_id = @item.id
      prev_id = -1
      next_id = -1
      first_id = arr_ids.first
      last_id = arr_ids.last
      ids_count = arr_ids.count

      for i in 0..arr_ids.count
        if arr_ids[i] == current_id

        end
      end

      arr_ids.each_with_index do | item, index |
        if item == current_id
          prev_id = arr_ids[index-1]
          next_id = arr_ids[index+1]

          if prev_id.nil?
            prev_id = last_id
          elsif next_id.nil?
            next_id = first_id
          end
        end
      end

      @next_portfolio = Portfolio::Portfolio.find(prev_id)
      @prev_portfolio = Portfolio::Portfolio.find(next_id)
    end

    #if @item
    #
    #  @next_portfolio = Portfolio::Portfolio.where( id: @item.id + 1 ).limit(1)
    #  if @next_portfolio.count == 0
    #    @next_portfolio = Portfolio::Portfolio.first
    #  else
    #    @next_portfolio = @next_portfolio.first
    #  end
    #
    #  @prev_portfolio = Portfolio::Portfolio.where( id: @item.id - 1 ).limit(1)
    #  if @prev_portfolio.count == 0
    #    @prev_portfolio = Portfolio::Portfolio.last
    #  else
    #    @prev_portfolio = @prev_portfolio.first
    #  end
    #
    #end

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
