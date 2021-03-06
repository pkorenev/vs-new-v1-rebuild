StudioVoronin::Application.routes.draw do



  get '/users/sign_up', :to => 'error#show', :code => 404
  get '/users', :to => 'error#show', :code => 404

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'


  get "test_slider/index"

  # prevent sign up as new admin


  get 'articles/tags/:tag', to: 'page#articles_by_tags', as: :article_tag

  get "empty", to: 'empty#index'

  get "custom_grid/index"

  get "partial_test/portfolio", :to => 'partial_test#portfolio'
  get "partial_test/home-slider", :to => 'partial_test#home_slider'





  

  # Define pages routes
  get 'about'   => 'page#about', :as => 'about'
  get 'service'   => 'page#service', :as => 'service'
  get 'articles'  => 'page#article', :as => 'article_list'
  
  #get 'articles/:id'  => 'page#article_item', :as => 'article'
 get 'articles/:id' => 'page#article_item', :as => 'article_item'
   get 'portfolio' => 'portfolio#index', :as => 'portfolio'

  # Portfolio routes
  #get 'portfolio/polygraphy' => 'portfolio#polygraphy', :as => 'portfolio_polygraphy'
  #get 'portfolio/polygraphy/:id' => 'portfolio#polygraphy_item', :as => 'portfolio_polygraphy_item'
  #get 'portfolio/corporate-identity' => 'portfolio#corporate_identity', :as => 'portfolio_corporate_identity'
  #get 'portfolio/corporate-identity/:id' => 'portfolio#corporate_identity_item', :as => 'portfolio_corporate_identity_item'
  #get 'portfolio/web' => 'portfolio#web', :as => 'portfolio_web'
  #get 'portfolio/web/:id' => 'portfolio#web_item', :as => 'portfolio_web_item'
  get 'portfolio/:category' => 'portfolio#category'
  get 'portfolio/:category/:item' => 'portfolio#item', as: :portfolio_item

  # Contacts and contacts-modal routes
  get 'contact' => 'page#contact', :as => 'contact'
  get 'contact-modal' => 'page#contact_modal', :as => 'contact_modal'
  get 'order-us' => 'page#order_us', :as => 'order_us'
  get 'connect-with-us' => 'page#connect_with_us', :as => 'connect_us'



  # errors

  get "/404", :to => "error#show", :code => 404
  get "/422", :to => "error#show", :code => 404
  get "/500", :to => "error#show", :code => 404



  # Rooting application
  root :to        => 'page#index', as: :root
    
  get '*a', :to => 'error#show', :code => 404



end
