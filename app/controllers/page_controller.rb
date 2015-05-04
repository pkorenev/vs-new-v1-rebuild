#encoding: utf-8
class PageController < ApplicationController
  layout :resolve_layout
  caches_page :service
  caches_page :article
  caches_page :service_item
  caches_page :article_item
  caches_page :about
  caches_page :index, if: -> {
                      params[:locale].present?
                    }

  # Index page
  # TODO: Version 1.2
  # Should limited articles, banners, and companys displaes

  def index
    hash_to_instance_vars(index_data)
    # @data = self.index_data
    # @get_banners = @data[:get_banners]
    # @featured_articles = @data[:featured_articles]
    # @our_clients = @data[:our_clients]
    # @portfolios = @data[:portfolios]
    # @page_data = @data[:page_data]
    # @static_page_data = @data[:static_page_data]
    # @greetings = @data[:greetings]
    # @portfolio_technologies = @data[:portfolio_technologies]
    # @portfolio_categories = @data[:portfolio_categories]
    # instance_variable_set("@my_instance_var", "hello")
  end

  def index_data
    data = {} 
    data[:get_banners] ||= Banner.where(published: true)
    data[:featured_articles] ||= Article.limit(3).where(published: true).order('release_date desc')
    data[:our_clients] ||= TrustCompany.all.order('RANDOM()').limit(15)

    data[:portfolios] ||= Portfolio::Portfolio.where(published: true).order('release desc')#.limit(12)
    data[:page_data] = Pages::HomePage.first
    data[:static_page_data] = data[:page_data].static_page_data
    data[:greetings] = data[:page_data].greetings

    data[:portfolio_technologies] = Portfolio::PortfolioTechnology.all

    data[:portfolio_categories] = Portfolio::PortfolioCategory.all

    data[:home_page] = true
 
    data
  end  

  def hash_to_instance_vars hash = {}
    if hash.keys.any?
      hash.each do |key, value|
        self.instance_variable_set("@#{key}", value)
      end 
    end  
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

  def service_item
    model = Service
    params_slug = params[:service_item]
    @service = model.translation_class.where(slug: params_slug, locale: I18n.locale)

    #render inline: @service.count.to_s

    if @service && @service.respond_to?(:count) && @service.count > 0
      @service =  model.find(@service.first.send("#{model.to_s.downcase}_id"))


    else
      versions = PaperTrail::Version.field_version_values_for_class(model.translation_class, :slug)
      found_version = nil
      versions.each do |v|
        if found_version.nil? && v.reify && v.reify.slug == params_slug
          found_version = v

        end
      end

      if found_version
        @service = found_version.item
        found_version_slug = found_version.reify.slug
        service_translation_current_version = Service.translation_class.find(@service.id)
        service_current_version = Service.find(service_translation_current_version.service_id)
        new_slug = service_current_version.slug



        #render inline: "content_locale: #{@content_locale}"


        # if published_locales.count < I18n.available_locales.count
        #   if published_locales.where(locale: I18n.locale)
        # end

        item_locale = @service

        redirect_to service_item: new_slug, :status => :moved_permanently
      else
        @service = nil
      end
    end

    if @service
      @content_locale = I18n.locale

      #I18n.available_locales.each do |locale|
      #  I18n.with_locale(locale.to_sym) do
      #    @links_for_locales[locale.to_sym] = service_item_path(service_item: @service.slug, locale: locale)
      #  end
      #end


      published_translations = @service.translations.where(published: true)
      published_locales = []
      published_translations.each do |t|
        published_locales.push(t.locale.to_sym)
      end

      if !published_locales.include?(@content_locale)
        @content_locale = http_accept_language.compatible_language_from(published_locales)
      end

     I18n.available_locales.each do |locale|
       I18n.with_locale(locale.to_sym) do 
         @links_for_locales[locale.to_sym] = service_item_path(service_item: @service.slug, locale: locale)
       end
     end

      @static_page_data = @service.static_page_data

      @related_projects = []
      # if @service.portfolio_tag_scope && @service.portfolio_tag_scope.tag_list.count > 0
      #   taggables = PortfolioTagScope.tagged_with(@service.portfolio_tag_scope.tag_list, any: true).where(scope_taggable_type: Portfolio::Portfolio.to_s).include(:scope_taggable)
      #   # = taggables.class.new
      #   taggables.each do |t|
      #     @related_projects.push(t.scope_taggable) if t.scope_taggable.class == Portfolio::Portfolio && t.scope_taggable.published
      #   end
      # end

      @related_projects = []
      #taggables = PortfolioTagScope.where(scope_taggable_type: Portfolio::Portfolio.to_s).joins(:scope_taggable).where(scope_taggable: { published: true }).tagged_with(@service.portfolio_tag_scope.tag_list)

      tag_list = @service.portfolio_tag_scope.tag_list
      taggables = PortfolioTagScope.where(scope_taggable_type: Portfolio::Portfolio.to_s).tagged_with(tag_list)
      taggables.push(tag_list)

      filtered_taggables = []

      taggables.each do |t|
        filtered_taggables.push t.scope_taggable if (t.respond_to?(:scope_taggable) && t.scope_taggable.published)
      end
      
      filtered_taggables.sort! { |a, b| a.release - b.release }

        filtered_taggables.each do |t|
          if @related_projects.count < 8
            @related_projects.push t
          end
        end
      a = 5 + 5

    else
      @content_locale = I18n.locale
    end



    #render inline: "content_locale: #{@content_locale}"

    @related_services = Service.all.limit(2)


  end

  def service
    @get_all_services ||= Service.where(published: true).order('sort_id asc')

    @page_data = Pages::ServicesPage.first
    @static_page_data = @page_data.static_page_data
    @services_intro = @page_data.intro_text
    @services_footer = @page_data.footer_text

    #cache_page "<body> <h1> hello </h2>       <p> test 123 test </p>   </body>", "/uk/test/1.html"
  end

  def article
    @articles ||= Article.where(published: true).order('release_date desc')

    @page_data = Pages::ArticlesListPage.first

    if @page_data
      @static_page_data = @page_data.static_page_data

    end
  end

  def get_related_articles(article)
    articles = Article.where("id <> #{article.id} and published = 't'").order('release_date desc')
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
    @article ||= Article.find_by_slug(params[:article_item])


    if @article
      if @article.methods.include? :count
        if @article.count > 0
          @article = @article.first
        end



      end

      @static_page_data = @article.static_page_data

      I18n.available_locales.each do |locale|
       I18n.with_locale(locale.to_sym) do
         @links_for_locales[locale.to_sym] = article_item_path(article_item: @article.slug, locale: locale)
       end
      end

      @related_articles = get_related_articles(@article)


    end





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
