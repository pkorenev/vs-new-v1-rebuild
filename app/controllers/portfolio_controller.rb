class PortfolioController < ApplicationController
  def index
    #@portfolios ||= Portfolio::Portfolio.all
    @portfolio_categories = Portfolio::PortfolioCategory.all
    @portfolios ||= Portfolio::Portfolio.where(published: true).order('release desc')
    #@portfolios ||= Portfolio::Portfolio.where(published: true).order('portfolio_category_id, release asc')
    @page_data = Pages::PortfolioListPage.first
    @static_page_data = @page_data.static_page_data
    #@portfolio_invitation_source = @page_data.portfolio_invitation

    @portfolio_description = Pages::PortfolioListPage.first.intro_text
  end

  def test
    #arr = [3,9,12,8,7,11,2,1,5,10,4,6]

    query = "SELECT p.id FROM portfolios p WHERE p.published = 't' ORDER BY p.portfolio_category_id, p.release asc"
    result = ActiveRecord::Base.connection.execute(query)
    arr = []
    result.each do | row |
      arr.push( row['id'] )
    end



    selected_number = 9
    prev_number = -1
    next_number = -1

    current_index = -1
    prev_index = -1
    next_index = -1

    arr.each_with_index do | number, index |
      if number == selected_number
        current_index = index

        prev_index = index - 1
        next_index = index + 1
      end
    end

    first_index = 0
    last_index = arr.count - 1

    if prev_index < first_index
      prev_index = last_index
    end

    if next_index > last_index
      next_index = first_index
    end

    # current index = OK
    # prev_index = OK
    # next_index = OK

    next_indices = []
    # generate next 4 indices
    for i in 1..4
      index = current_index + i

      if index > last_index
        index = index - last_index - 1
      end

      next_indices.push index
    end

    #next_indices.rev



    prev_indices = []
    # generate prev 4 indices
    for i in 1..4
      index = current_index - i

      if index < first_index
        index = last_index + index + 1
      end

      prev_indices.push index
    end

    prev_indices.reverse!



    # numbers

    next_number = arr[next_index]
    prev_number = arr[prev_index]

    prev_numbers = []

    prev_indices.each do | index |
      prev_numbers.push arr[index]
    end

    next_numbers = []

    next_indices.each do | index |
      next_numbers.push arr[index]
    end

    output_arr = prev_numbers + next_numbers

    render inline: 'array: ' + arr.join(', ') + '<br/>' + 'current_number: ' + selected_number.to_s + '<br/><br/>' + 'first_index: ' + first_index.to_s + '; last_index: ' + last_index.to_s + ';current_index: ' + current_index.to_s + '<br/>' +
        'prev: ' + prev_index.to_s + '; next: ' + next_index.to_s + '<br/>prev: ' + prev_indices.join(', ') + '<br/>next: ' + next_indices.join(', ') + '<br/></br>' +
        'prev_number: ' + prev_number.to_s + '; next_number: ' + next_number.to_s + '<br/>prev_numbers: ' + prev_numbers.join(', ') + '<br/>next_numbers: ' + next_numbers.join(', ') + '<br/>' +
        output_arr.join(', ')



  end

  def item

    @category = Portfolio::PortfolioCategory.where(slug: params[:category]).first

    @item = Portfolio::Portfolio.where(slug: params[:item], published: 't', portfolio_category_id: @category.id).limit(1) if @category 
    
    testing = false # params[:test]
    

    if @item && @item.count == 1
      @item = @item.first
    end

    if @item.nil?
      @available_translations = Portfolio::Portfolio.translation_class.where(slug: params[:item], published_translation: true)
      @available_translations = @available_translations.where.not(locale: I18n.locale.to_s)
    end 

    
    
    

    if @item && !@item.respond_to?(:count)
      @translated_locales = @item.published_locales
      @untranslated_locale = !@translated_locales.include?(I18n.locale)
      
      I18n.available_locales.each do |locale|
       I18n.with_locale(locale.to_sym) do
         @links_for_locales[locale.to_sym] = portfolio_item_path(item: @item.slug, category: @item.portfolio_category.slug, locale: locale)
       end
      end

      if testing

        #render inline: @item.result.blank?.
      end

      unless testing

      @static_page_data = @item.static_page_data
      query = "SELECT p.id FROM portfolios p WHERE p.published = 't' ORDER BY p.portfolio_category_id, p.release asc"
      result = ActiveRecord::Base.connection.execute(query)
      arr = []
      result.each do | row |
        arr.push( row['id'] )
      end

      filter_count = 8

      selected_number = @item.id

      prev_number = -1
      next_number = -1

      current_index = -1
      prev_index = -1
      next_index = -1

      arr.each_with_index do | number, index |
        if number == selected_number
          current_index = index

          prev_index = index - 1
          next_index = index + 1
        end
      end

      first_index = 0
      last_index = arr.count - 1

      if prev_index < first_index
        prev_index = last_index
      end

      if next_index > last_index
        next_index = first_index
      end

      # current index = OK
      # prev_index = OK
      # next_index = OK

      next_indices = []
      # generate next 4 indices
      for i in 1..(filter_count / 2)
        index = current_index + i

        if index > last_index
          index = index - last_index - 1
        end

        next_indices.push index
      end

      #next_indices.rev



      prev_indices = []
      # generate prev 4 indices
      for i in 1..(filter_count / 2)
        index = current_index - i

        if index < first_index
          index = last_index + index + 1
        end

        prev_indices.push index
      end

      prev_indices.reverse!



      # numbers

      next_number = arr[next_index]
      prev_number = arr[prev_index]

      prev_numbers = []

      prev_indices.each do | index |
        prev_numbers.push arr[index]
      end

      next_numbers = []

      next_indices.each do | index |
        next_numbers.push arr[index]
      end

      output_arr = prev_numbers + next_numbers

      @next_portfolio = Portfolio::Portfolio.find(next_number)
      @prev_portfolio = Portfolio::Portfolio.find(prev_number)
      @other_projects = []

      output_arr.each do | number |
        @other_projects.push Portfolio::Portfolio.find(number)
      end




    else
      render template: 'error/404' unless testing


    end

    end
  end

  def item_bc
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
      @translated_locales = []
      @item.tra


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


      current_index = -1
      arr_ids.each_with_index do | item, index |
        if item == current_id
          current_index = index
          prev_id = arr_ids[index-1]
          next_id = arr_ids[index+1]

          if prev_id.nil?
            prev_id = last_id
          elsif next_id.nil?
            next_id = first_id
          end
        end
      end

      @other_projects = []
      projs_start_index = current_index - 4
      projs_end_index = current_index + 4
      total = arr_ids.count

      if projs_start_index < 0

      end

      other_projects_ids = []

      for i in projs_end_index..projs_start_index
        if i != current_index
          id = arr_ids[i]
          if i < 0
            id = arr_ids[total + i]
          elsif i > total - 1
            id = arr_ids[ i + 1 - total ]
          end

          other_projects_ids[other_projects_ids.count] = id
        end
      end

      @other_projects = []

      other_projects_ids.each do | id |
        @other_projects[@other_projects.count] = Portfolio::Portfolio.find(id)
      end

      @static_page_data = @item.static_page_data

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
    @portfolio_categories = Portfolio::PortfolioCategory.all
    @portfolios ||= Portfolio::Portfolio.where(published: true).order('release desc')
    #@portfolios ||= Portfolio::Portfolio.where(published: true).order('portfolio_category_id, release asc')
    @static_page_data = Pages::PortfolioListPage.first.static_page_data

    requested_category_slug = params[:category]

    @active_category = Portfolio::PortfolioCategory.where(slug: requested_category_slug)
    if @active_category && @active_category.count >= 1
      @active_category = @active_category.first


      @portfolio_description = @active_category.full_description
      @static_page_data = @active_category.static_page_data


      I18n.available_locales.each do |locale|
       I18n.with_locale(locale.to_sym) do
         @links_for_locales[locale.to_sym] = portfolio_category_path(category: @active_category.slug, locale: locale)
       end
      end

    end
    render template: 'portfolio/category'
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
