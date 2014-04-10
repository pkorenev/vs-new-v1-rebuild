#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  #has_mobile_fu
  #has_mobile_fu
  helper :application, :facebook, :webfont

  helper_method :get_menu

  def get_menu
  	arr = []
  	arr[0] = {:data_url => about_path, :id => 'li-about', :title => 'ХТО - Про студію', :is_active => request[:controller] == 'page' && request[:action] == 'about', :header => 'ХТО', :description => 'Про студію'}
  	arr[1] = {:data_url => service_path, :id => 'li-service', :title => 'ЩО - Наші послуги', :is_active => request[:controller] == 'page' && request[:action] == 'service', :header => 'ЩО', :description => 'Наші послуги'}
  	arr[2] = {:data_url => portfolio_path, :id => 'li-portfolio', :title => 'ЯК - Портфоліо', :is_active => request[:controller] == 'portfolio', :link => !( request[:controller] == 'portfolio' && request[:action] == 'index' ), :header => 'ЯК', :description => 'Портфоліо'}
  	arr[3] = {:data_url => article_list_path, :id => 'li-article', :title => 'КОЛИ - Анонси та події', :is_active => request[:controller] == 'page' && (request[:action] == 'article' || request[:action] == 'article_item'), :header => 'КОЛИ', :description => 'Анонси та події'}
  	arr[4] = {:data_url => contact_modal_path, :id => 'contact-form', :title => 'ХТО - Про студію', :is_active => request[:controller] == 'page' && request[:action] == 'contact', :header => 'ДЕ', :description => 'Наші контакти'}
  
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
end
