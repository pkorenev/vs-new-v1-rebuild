#encoding: utf-8
module ApplicationHelper

  # MD5 Body data settings
  def hide_setting(data)
    Digest::MD5.hexdigest(data)
  end

  def sha1(data)
    Digest::SHA2.hexdigest(data)
  end




  # Pages titles
  def title(page_title)
    if page_title.present?
      content_for(:title) { page_title } # Render yield
    else
      page_title = "Дизайн студія Миколи Вороніна (Львів). Графічний дизайн. Створення веб-сайтів. Поліграфія."
      content_for(:title) { page_title } # Render yield
    end
  end

  # Def method @meta
  def meta(meta_keywords, meta_description)
    if meta_keywords.present? && meta_description.present?
      content_for(:meta_keywords) { meta_keywords }
      content_for(:meta_description) { meta_description }
    end
  end

  # Get current env
  def current_env
    Rails.env
  end

  # Display copyrights
  def show_copyrights
    if current_env == 'development'
      copyrights = "<p class='site-copyrights'>© 2006 — #{Time.now.year} #{link_to(t('layout.footer.copyright.studio-link.title'), root_path, :class => 'animate')}<b>.</b> #{ t('layout.footer.copyright.all-rights-reserved') }<b>.</b></p>"
      copyrights.html_safe
    else
      copyrights = "<p class='site-copyrights'>© 2006 — #{Time.now.year} #{link_to(t('layout.footer.copyright.studio-link.title'), root_path, :class => 'animate')}#{ t('layout.footer.copyright.all-rights-reserved') }</p>"
      copyrights.html_safe
    end
  end

  # Get lates published banners
  def get_banner_home(limit)
    @banners ||= Banner.where(:published => true)
  end

  # Get lates trusted companies
  def get_home_trust(limit)
    @trusts ||= TrustCompany.where(:published => true)
  end

  # Get 3 latest articles
  def get_lates_articles(limit)
    @articles ||= Article.where(:published => true, :limit => limit)
  end

  def self.dictionary(key, locale = I18n.locale)
    parts = key.split('.')
    dictionary_name = parts.first
    parts.delete_at(0)
    key_path = parts.join('.')
    dic = Dictionary.where(code_name: dictionary_name)
    if dic.count > 0
      dic = dic.first
      keys = dic.dictionary_keys.where(key: key_path)
      if keys.count > 0
        k = keys.first
        return k.translations_by_locale[locale].value
      else
        return ''
      end
    else
      return ''
    end
  end

  def d(key, locale = I18n.locale)
    self.dictionary(key, locale)
  end


  # def link_to name = nil, options = nil, html_options = nil, &block
  #   html_options, options, name = options, name, block if block_given?
  #   options ||= {}

  #   html_options = convert_options_to_data_attributes(options, html_options)

  #   url = url_for(options)
  #   html_options['href'] ||= url
  #   html_options['hreflang'] ||= I18n.locale

  #   content_tag(:a, name || url, html_options, &block)
  # end  

end

#ApplicationHelper.module_eval { include ActionView::RoutingUrlFor ; include ActionView::Helpers::UrlHelper }

module A
  def foo
    "foo"
  end  
end  

module B
  def foo
    super + "2"
  end  
end 

B.module_eval { include A }

class C
  include B
  def bar
    foo + "c"
  end  
end 