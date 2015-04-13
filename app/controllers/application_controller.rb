#encoding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery
  #has_mobile_fu
  #has_mobile_fu
  helper :application, :facebook, :webfont

  helper_method :get_menu


  before_action :set_mailer_host, :init_modal_form

  before_action :set_locale

  def set_locale
    #render inline: params[:controller]

    if !params[:controller].match(/^rails_admin/) && !params[:controller].match(/^file_editor/) && !(params[:controller] == 'error')
      params_locale = params[:locale]
      locale = params_locale

      cookies_locale = cookies[:locale]

      if !locale || !I18n.available_locales.include?(locale.to_sym)
        locale = cookies_locale
      end

      if !locale || !I18n.available_locales.include?(locale.to_sym)
        locale = http_accept_language.compatible_language_from(I18n.available_locales)
      end

      #render inline: "#{locale == params_locale}"

      if locale != cookies_locale
        cookies[:locale] = {
          value: locale,
          expires: 1.year.from_now
        }
      end

      if locale != params_locale
        redirect_to locale: locale, :status => :moved_permanently
      else
        I18n.locale = locale
      end
    elsif params[:controller].match(/^rails_admin/)
      I18n.locale = :ru
    end

  end

  before_action :init_translated_locales

  def init_translated_locales
    @translated_locales = [:uk]
    @links_for_locales = {}
    I18n.available_locales.each do |locale|
      @links_for_locales[locale.to_sym] = url_for(locale: locale )
    end
  end



  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def init_modal_form
    @join_us = Forms::JoinUs.new
    @order = Forms::Order.new
  end

  def d(key, locale = I18n.locale)
    ApplicationHelper.dictionary(key, locale)
  end


  def get_menu
  	arr = []
  	arr[0] = {:data_url => about_path, :id => 'li-about', :title => 'ХТО - Про студію', :is_active => request[:controller] == 'page' && request[:action] == 'about', :header => d('main_menu.about.header'), :description => d('main_menu.about.description')}
  	arr[1] = {:data_url => service_list_path, :id => 'li-service', :title => 'ЩО - Наші послуги', :is_active => request[:controller] == 'page' && request[:action] == 'service', :header => d('main_menu.services.header'), :description => d('main_menu.services.description')}
  	arr[2] = {:data_url => portfolio_path, :id => 'li-portfolio', :title => 'ЯК - Портфоліо', :is_active => request[:controller] == 'portfolio', :link => !( request[:controller] == 'portfolio' && request[:action] == 'index' ), :header => d('main_menu.portfolio.header'), :description => d('main_menu.portfolio.description')}
  	arr[3] = {:data_url => article_list_path, :id => 'li-article', :title => 'КОЛИ - Анонси та події', :is_active => request[:controller] == 'page' && (request[:action] == 'article' || request[:action] == 'article_item'), :header => d('main_menu.articles.header'), :description => d('main_menu.articles.description')}
  	arr[4] = {:data_url => contact_path, :id => 'contact-form', :title => 'ДЕ - Наші контакти', :is_active => request[:controller] == 'page' && request[:action] == 'contact', :header => d('main_menu.contact.header'), :description => d('main_menu.contact.description')}
  
  	return arr
  end

  helper_method :image_sprite

  def image_sprite(image, options = {}) 
    sprites = {
      :add_icon           => {:w => 16,   :h => 16,   :x => 0,    :y => 0},
      :email              => {:w => 26,   :h => 16,   :x => 41,   :y => 0},
      :print              => {:w => 25,   :h => 17,   :x => 68,   :y => 0},
      :trash              => {:w => 10,   :h => 11,   :x => 94,   :y => 0},
      :comments           => {:w => 13,   :h => 13,   :x => 105,  :y => 0},
      :comments_read      => {:w => 13,   :h => 13,   :x => 120,  :y => 0},
      :comments_unread    => {:w => 13,   :h => 13,   :x => 135,  :y => 0},
      :rss                => {:w => 14,   :h => 14,   :x => 150,  :y => 0},
      :ical               => {:w => 14,   :h => 16,   :x => 166,  :y => 0},
      :drag               => {:w => 11,   :h => 11,   :x => 360,  :y => 0},
      :timeclock          => {:w => 17,   :h => 17,   :x => 375,  :y => 0},
      :timeclock_off      => {:w => 17,   :h => 17,   :x => 392,  :y => 0}
    }
    %(<span class="sprite #{options[:class]}" style="background: url(#{path_to_image('/images/basecamp_sprites.png')}) no-repeat -#{sprites[image][:x]}px -#{sprites[image][:y]}px; width: #{sprites[image][:w]}px; padding-top: #{sprites[image][:h]}px; #{options[:style]}" title="#{options[:title]}">#{options[:title]}</span>)
  end

  def image_fragment
    
  end

  def brand_tab(title)
    render template: 'helpers/application/brand_tab.html', locals: { title: title }
  end

  #after_action :join_html_output

  def join_html_output
    response.body.gsub!(/>\s+</, '><')
  end


end
