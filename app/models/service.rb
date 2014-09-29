# -*- encoding : utf-8 -*-
class Service < ActiveRecord::Base
  attr_accessible :sort_id, :published, :name, :short_description, :full_description, :slug


  has_attached_file :avatar
  [:avatar].each do |paperclip_field_name|
    attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

    attr_accessor "delete_#{paperclip_field_name}".to_sym
  end

  validates :sort_id, :uniqueness => true, :presence => true

  has_paper_trail

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  has_one :portfolio_tag_scope, :as => :scope_taggable
  attr_accessible :portfolio_tag_scope
  accepts_nested_attributes_for :portfolio_tag_scope, :allow_destroy => true
  attr_accessible :portfolio_tag_scope_attributes
  before_save do
    if !portfolio_tag_scope
      self.build_portfolio_tag_scope
    end
  end


  translates :short_description, :full_description, :avatar_alt, :slug, :name, :versioning => :paper_trail
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :short_description, :full_description, :avatar_alt, :slug, :name

    # def published=(value)
    #   self[:published] = value
    # end

    before_save do
      if !self.slug || self.slug.length == 0
        if I18n.locale != :ru
          locale = I18n.locale
          I18n.locale = :ru
          self.slug = self.name.parameterize
          I18n.locale = locale
        end
      end
    end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :name
        field :slug
        field :short_description
        field :full_description, :ck_editor
        field :avatar_alt
      end
    end
  end




  belongs_to :services_page, :class_name => 'Pages::ServicesPage'
  attr_accessible :services_page, :services_page_id

  before_validation :configure_sort_id

  def configure_sort_id
    sort_id ||= id
  end

  # before_validation :generate_slug
  # before_validation :generate_name

  # def generate_slug
  #   self.slug ||= self.name.parameterize
  # end

  def generate_name
    self.name ||= "service-#{self.id}"
  end

#  before_save :detect_rename_avatar



  def detect_rename_avatar

    #self.avatar_file_name_fallback = 'hello'

    if !avatar_file_name_fallback || avatar_file_name_fallback == ''
      self.avatar_file_name_fallback = avatar_file_name
    end



    if self.avatar_file_name != self.avatar_file_name_fallback && self.avatar.exists?



      folder_names = avatar.styles.keys
      folder_names.push('original')
      #self.avatar_file_name = "vs-logo-1.jpg#{folder_names.count}"

      if avatar_file_name_fallback_changed? && avatar_file_name_fallback_was != nil
        if !new_record?


        old_name = avatar_file_name_fallback_was
        new_name = avatar_file_name_fallback

        original_folder_name = 'original'

        original_old_file_path = avatar.path(original_folder_name)
        original_old_file_path_array = original_old_file_path.split('/')
        original_old_file_path_array[original_old_file_path_array.count - 1] = old_name


        original_new_file_path = avatar.path(original_folder_name)
        original_new_file_path_array = original_new_file_path.split('/')
        original_new_file_path_array[original_new_file_path_array.count - 1] = new_name

        #if original_old_file_path


          original_old_file_path = original_old_file_path_array.join('/')


          if original_old_file_path != original_new_file_path

          if !File.exist?(original_old_file_path)
            self.avatar_file_name_fallback = old_name
          else



            folder_names.each do |folder_name|
              old_file_path = avatar.path(folder_name)
              new_file_path = old_file_path

              old_file_path_array = old_file_path.split('/')
              old_file_path_array[old_file_path_array.count - 1] = old_name
              old_file_path = old_file_path_array.join('/')





              if File.exist?(old_file_path) && !File.exist?(new_file_path)
                FileUtils.mv(old_file_path, new_file_path)
              end
            end

            self.avatar_file_name_fallback = "#{original_new_file_path == original_old_file_path}"

            #self.avatar_file_name = new_name
          end

          end

        #end


        else

        end

      end
    end
  end

  rails_admin do
    configure :sort_id do
      label 'Порядок сортировки на странице вывода всех сервисов'
    end

    configure :published do
      label 'опубликовать'
    end

    configure :avatar_file_name_fallback do
      label 'имя файла'
      help 'должен включать расширение. Например: gav-upakovka.jpg'
    end

    configure :static_page_data do
      label 'Данные о странице'
    end

    configure :services_page do

    end

   list do
   field :sort_id do
     #label 'id'
    end
    field :published
    field :name
    field :short_description
    field :avatar
   end

   edit do
    field :sort_id do
     label ''

    end
    field :published

    field :portfolio_tag_scope do
      active true
      label 'теги'
    end
    #field :name
    # field :slug do
    #   label 'url part'
    # end
    # field :short_description
    # field :full_description, :ck_editor
    field :translations, :globalize_tabs



    # field :avatar_alt do
    #   group :image_data
    # end
    group :image_data do
      field :avatar
      field :avatar_file_name_fallback do

        label 'file name'
      end
    end
     field :services_page

    field :static_page_data


   end
  end
end


#Service.all.each  {|s| translated_locales = s.translations_by_locale.keys; I18n.available_locales.each {|locale| if !translated_locales.include?(locale) then; t = s.class.translation_class.new; t.service_id = s.id; t.locale = locale; t.short_description = s.short_description; t.full_description = s.full_description; t.avatar_alt = s.avatar_alt; t.slug = s.slug; t.name = s.name; t.save;  end;  } }