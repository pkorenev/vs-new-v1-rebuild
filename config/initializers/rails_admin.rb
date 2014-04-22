#encoding: utf-8

Rails.configuration.to_prepare do
  #require '../../app/helpers/rails_admin/application_helper_patch'
  #require "#{RailsRoot}/lib/rails_admin/config_patch"
  require File.expand_path('../../../lib/rails_admin/config_patch', __FILE__)

  RailsAdmin::Config.send     :include, RailsAdmin::ConfigPatch
  RailsAdmin::ApplicationHelper.send     :include, RailsAdmin::ApplicationHelperPatch

end

RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.navigation_static_links = {
      'Corporate identity' => 'http://localhost:3000/admin/portfolio~portfolio?utf8=%E2%9C%93&f[portfolio_category][58574][o]=is&f[portfolio_category][58574][v]=Corporate+identity&query=',
      'Polygraphy' => 'http://localhost:3000/admin/portfolio~portfolio?utf8=%E2%9C%93&f[portfolio_category][58574][o]=is&f[portfolio_category][58574][v]=Polygraphy&query=',
      'Web' => 'http://localhost:3000/admin/portfolio~portfolio?utf8=%E2%9C%93&f[portfolio_category][58574][o]=is&f[portfolio_category][58574][v]=web&query=',
      'About Page' => ''
  }

  [
      Pages::AboutPage,
      Pages::ArticlesListPage,
      Pages::HomePage,
      Pages::PortfolioCorporateIdentityListPage,
      Pages::PortfolioListPage,
      Pages::PortfolioPolygraphyListPage,
      Pages::PortfolioWebListPage,
      Pages::ServicesPage,
      Pages::AboutPage,
      Pages::AboutPage,
      Pages::AboutPage,

      Banner,
      StaticPageData,

      Portfolio::PortfolioBanner,
      Portfolio::PortfolioCategory,
      Portfolio::PortfolioTechnology,
      Portfolio::Portfolio,

      Ckeditor::Asset,
      Ckeditor::AttachmentFile,
      Ckeditor::Picture,

      TrustCompany,
      Service,

      Article,

      User,

      Developer,
      DeveloperRole


  ].each do | model |
    config.model model.name do
      visible false
    end
  end

  config.navigation_static_label = "Static Pages"

  root = Tree::TreeNode.new('navigation_static_tree')
  root << Tree::TreeNode.new( 'seo' )
  root << Tree::TreeNode.new( 'portfolio', title: 'Портфолио' )
  root << Tree::TreeNode.new( 'articles', title: 'Статті' )
  root << Tree::TreeNode.new( 'team', title: 'Команда' )
  root << Tree::TreeNode.new( 'users', title: 'Users' )

  seo = root['seo']
  seo << Tree::TreeNode.new( 'Головна', { link: '/admin/pages~home_page/1/edit' } )
  seo << Tree::TreeNode.new( 'Про нас', { link: '/admin/pages~about_page/1/edit' } )
  seo << Tree::TreeNode.new( 'Наші послуги', { link: '/admin/pages~services_page/1/edit' } )
  seo << Tree::TreeNode.new( 'Статті', { link: '/admin/pages~articles_list_page/1/edit' } )
  seo_portfolio = Tree::TreeNode.new( 'Портфоліо - список', { link: '/admin/pages~portfolio_list_page/1/edit' } )
  seo << seo_portfolio
  seo_portfolio << Tree::TreeNode.new( 'Поліграфія', { link: '/admin/pages~portfolio_polygraphy_list_page/1/edit' } )
  seo_portfolio << Tree::TreeNode.new( 'Фірмовий стиль', { link: '/admin/pages~portfolio_corporate_identity_list_page/1/edit' } )
  seo_portfolio << Tree::TreeNode.new( 'Веб', { link: '/admin/pages~portfolio_web_list_page/1/edit' } )

  portfolio = root['portfolio']
  portfolio_portfolio = Tree::TreeNode.new( 'Портфоліо - список', { link: '/admin/portfolio~portfolio' } )
  portfolio << portfolio_portfolio
  portfolio_portfolio << Tree::TreeNode.new( 'Поліграфія', { link: '/admin/portfolio~portfolio?utf8=%E2%9C%93&f[portfolio_category][58574][o]=is&f[portfolio_category][58574][v]=Polygraphy&query=' } )
  portfolio_portfolio << Tree::TreeNode.new( 'Фірмовий стиль', { link: '/admin/portfolio~portfolio?utf8=%E2%9C%93&f[portfolio_category][58574][o]=is&f[portfolio_category][58574][v]=Corporate+identity&query=' } )
  portfolio_portfolio << Tree::TreeNode.new( 'Веб', { link: '/admin/portfolio~portfolio?utf8=%E2%9C%93&f[portfolio_category][58574][o]=is&f[portfolio_category][58574][v]=web&query=' } )

  portfolio << Tree::TreeNode.new( 'Технології', { link: '/admin/portfolio~portfolio_technology' } )

  articles = root['articles']
  articles << Tree::TreeNode.new( 'Статті', { link: '/admin/article' } )

  users = root['users']
  users << Tree::TreeNode.new( 'users', { title: 'Users', link: '/admin/user' } )

  team = root['team']
  team << Tree::TreeNode.new( 'Developers', { title: 'Developers', link: '/admin/developer' } )
  team << Tree::TreeNode.new( 'Developer roles', { title: 'Developer roles', link: '/admin/developer_role' } )





  # config.navigation_static_tree = root

  config.navigation_static_links = root


end
