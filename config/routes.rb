Rails.application.class.routes.draw do



  get "test", to: "test#test", as: :test

  #get '/test', to: 'test#media_queries'

  get 'sitemap.xml', to: 'sitemap#index'

  get 'googleb4007362349b57e0.html', to: 'google_analytics#confirm'

  scope "(:locale)", constraints: { locale: /[a-zA-Z]{2,2}/ } do

    get "test2", to: "test#test2"

    get '/users/sign_up', :to => 'error#show', :code => 404
    get '/users', :to => 'error#show', :code => 404


    match '/file_editor/(*path)', to: 'file_editor#index', via: [:get, :post], format: false, as: :file_editor
    match '/file_editor(*path)', to: 'file_editor#index', via: [:get, :post], format: false, as: :file


    devise_for :users
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    mount Ckeditor::Engine => '/ckeditor'

    root to: 'page#index', as: :root, defaults: { root_page: true  }
  end



  DynamicRouter.load
  # Portfolio routes
  # get '/portfolio', to: 'portfolio#index', :as => 'portfolio'
  # get '/portfolio/:category', to: 'portfolio#category', as: :portfolio_category
  # get '/portfolio/:category/:item' => 'portfolio#item', as: :portfolio_item

  #get 'test', to: 'portfolio#test'

  #post '/order', to: 'order#submit_form'

  # Contacts and contacts-modal routes
  #get '/contact' => 'contact#contact_show', :as => 'contact'
  #get '/order' => 'contact#order_show', :as => 'order'
  #get '/join-us' => 'contact#join_us_show', :as => 'join_us'
  #get '/contact-modal' => 'page#contact_modal', :as => 'contact_modal'

  #post '/order', to: 'contact#order_create'
  #post '/join-us', to: 'contact#join_us_create'








  #get "test_slider/index"

  # prevent sign up as new admin


  #get 'articles/tags/:tag', to: 'page#articles_by_tags', as: :article_tag

  #get "empty", to: 'empty#index'

  #get "custom_grid/index"

  #get "partial_test/portfolio", :to => 'partial_test#portfolio'
  #get "partial_test/home-slider", :to => 'partial_test#home_slider'





  

  # Define pages routes
  #get 'about'   => 'page#about', :as => 'about'
  #get 'services/:service_item', to: 'page#service_item', as: :service_item
  #get 'services'   => 'page#service', :as => 'service_list'
  #get 'articles'  => 'page#article', :as => 'article_list'
  
  #get 'articles/:id'  => 'page#article_item', :as => 'article'
 #get 'articles/:id' => 'page#article_item', :as => 'article_item'


  # Portfolio routes
  #get 'portfolio/polygraphy' => 'portfolio#polygraphy', :as => 'portfolio_polygraphy'
  #get 'portfolio/polygraphy/:id' => 'portfolio#polygraphy_item', :as => 'portfolio_polygraphy_item'
  #get 'portfolio/corporate-identity' => 'portfolio#corporate_identity', :as => 'portfolio_corporate_identity'
  #get 'portfolio/corporate-identity/:id' => 'portfolio#corporate_identity_item', :as => 'portfolio_corporate_identity_item'
  #get 'portfolio/web' => 'portfolio#web', :as => 'portfolio_web'
  #get 'portfolio/web/:id' => 'portfolio#web_item', :as => 'portfolio_web_item'





  # errors

  get "/404", :to => "error#show", :code => 404
  get "/422", :to => "error#show", :code => 404
  get "/500", :to => "error#show", :code => 404



  # Rooting application

    
  get '*a', :to => 'error#show', :code => 404



end
