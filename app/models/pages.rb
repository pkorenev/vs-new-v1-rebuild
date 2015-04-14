module Pages
  def self.table_name_prefix
    'pages_'
  end

  def self.expire_all!
    %w[AboutPage ArticlesListPage ContactPage HomePage JoinUsPage OrderPage PortfolioListPage ServicesPage].each do |class_name|
      klass = "Pages::#{class_name}".constantize
      klass.first.expire
    end
  end
end
