class SitemapController < ApplicationController
  def index
    @sitemap_entries = []
    # static_pages = []
    # static_pages.push({ loc: about_url, data: Pages::AboutPage.first.static_page_data })
    # static_pages.push({ loc: article_main_url, data: Pages::ArticlesPage.first.static_page_data })
    # static_pages.push({ loc: catalog_colors_url, data: Pages::CatalogColorsPage.first.static_page_data })
    # static_pages.push({ loc: catalog_url, data: Pages::CatalogPage.first.static_page_data })
    # static_pages.push({ loc: catalog_blagoustriy_url, data: Pages::CatalogServicesPage.first.static_page_data })
    # static_pages.push({ loc: gallery_albums_url, data: Pages::GalleryAlbumsPage.first.static_page_data })
    # static_pages.push({ loc: gallery_images_url, data: Pages::GalleryImagesPage.first.static_page_data })
    # static_pages.push({ loc: gallery_url, data: Pages::GalleryImagesPage.first.static_page_data })
    # static_pages.push({ loc: root_url, data: Pages::HomePage.first.static_page_data })
    #
    #
    # #render inline: static_pages.inspect
    #
    # static_pages.each do | p |
    #   @sitemap_entries.push( { loc: p[:loc], changefreq: p[:data].sitemap_change_frequency, priority: p[:data].sitemap_priority } )
    # end
    #
    # catalog_pdf = SitemapConfig.find(4)
    # price_pdf = SitemapConfig.find(5)
    #
    # @sitemap_entries.push( { loc: root_url + 'assets/' + ('Rysun-o-katalog-29.04.2013-prv.pdf'), changefreq: catalog_pdf.default_priority, priority: catalog_pdf.default_change_frequency, lastmod: '2014-04-28T13:13:05+00:00' } )
    # @sitemap_entries.push( { loc: root_url + 'assets/' + ('Rusyn-o-price.pdf'), changefreq: price_pdf.default_priority, priority: price_pdf.default_change_frequency, lastmod: '2014-04-28T13:12:56+00:00' } )
    #
    # # catalog categories
    # category_default = SitemapConfig.find(2)
    #
    # Catalog4::Category.where(parent_category_id: nil).each do | c |
    #   changefreq = c.object_metadata.sitemap_change_frequency
    #   if changefreq.nil? || changefreq == :default || changefreq == ''
    #     changefreq = category_default.default_change_frequency
    #   end
    #
    #   priority = c.object_metadata.sitemap_priority
    #   if priority.nil? || priority == ''
    #     priority = category_default.default_priority
    #   end
    #
    #   @sitemap_entries.push( { loc: catalog_category_url(c.category_url), changefreq: changefreq, priority: priority } )
    # end
    #
    #
    #
    # # articles
    # article_default = SitemapConfig.find(1)
    #
    # Article.all.each do | a |
    #   changefreq = a.object_metadata.sitemap_change_frequency
    #   if changefreq.nil? || changefreq == :default || changefreq == ''
    #     changefreq = article_default.default_change_frequency
    #   end
    #
    #   priority = a.object_metadata.sitemap_priority
    #   if priority.nil? || priority == ''
    #     priority = article_default.default_priority
    #   end
    #
    #   @sitemap_entries.push( { loc: publication_item_url(a.article_url), changefreq: changefreq, priority: priority } )
    # end
    #
    #
    #
    # # articles
    # article_default = SitemapConfig.find(1)
    #
    # Gallery::Album.all.each do | a |
    #   changefreq = a.object_metadata.sitemap_change_frequency
    #   if changefreq.nil? || changefreq == :default || changefreq == ''
    #     changefreq = article_default.default_change_frequency
    #   end
    #
    #   priority = a.object_metadata.sitemap_priority
    #   if priority.nil? || priority == ''
    #     priority = article_default.default_priority
    #   end
    #
    #   @sitemap_entries.push( { loc: gallery_album_url(a.url), changefreq: changefreq, priority: priority } )
    # end

    #@sitemap_entries.push( [ loc: about_url, changefreq: Pages::AboutPage.first.static_page_data.sitemap_change_frequency, priority: Pages ] )

    SitemapElement.where(display_on_sitemap: true).each do |e|
      entry = { loc: e.url, changefreq: e.change_frequency, priority: e.priority.to_s, lastmod: e.lastmod.to_s }
      @sitemap_entries.push entry
    end


    render template: 'sitemap/db_index.xml'
    #render template: 'sitemap/index.xml'
  end
end
