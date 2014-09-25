# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  attr_accessible :published, :name, :title, :slug, :short_description, :content, :original_published, :avatar, :avatar_file_name, :delete_avatar, :tags, :tag_list, :release_date, :author

  acts_as_taggable
  attr_accessible :tag_list

  #translates :name, :title, :slug, :short_description, :author, :content

  validates :name, :presence => true

  validates :title, :presence => true, length: { maximum: 70 }

  validates :short_description, :presence => true, length: { maximum: 250 }

  has_attached_file :avatar

  # Paperclip image attachments
  has_attached_file :avatar, :styles => { :thumb => '150x150>', :article_item => '320x320>', home_article_item: '250x250>', article_page: '500x500>'},
                    :url  => '/assets/articles/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/articles/:id/:style/:basename.:extension'



  translates :name, :slug, :short_description, :content, :avatar_alt
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :name, :slug, :short_description, :content, :avatar_alt

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :name
        field :slug
        field :short_description
        field :content, :ck_editor
        field :avatar_alt
      end
    end
  end


  before_validation :generate_slug
  before_validation :generate_title
  before_save :generate_release_date

  def generate_slug
  	self.slug ||= self.name.parameterize
  end

  def generate_title
    self.title ||= self.name
  end

  #before_validation :generate_release_date

  def generate_release_date
    #self.short_description ||= 'my_default_short_description'
    #self.release_date ||= self.created_at
    #release_date = Date.yesterday
    self.release_date ||= DateTime.now
  end

  before_save :detect_rename_avatar

  def detect_rename_avatar
    folder_names = avatar.styles.keys
    folder_names.push('original')
    #self.avatar_file_name = "vs-logo-1.jpg#{folder_names.count}"

    if avatar_file_name_changed?
      if !new_record?
        old_name = self.avatar_file_name_was
        new_name = self.avatar_file_name

        original_folder_name = 'original'

        original_old_file_path = avatar.path(original_folder_name)
        original_new_file_path = original_old_file_path

        original_old_file_path_array = original_old_file_path.split('/')
        original_old_file_path_array[original_old_file_path_array.count - 1] = old_name
        original_old_file_path = original_old_file_path_array.join('/')

        if !File.exist?(original_old_file_path)
          self.avatar_file_name = old_name
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
        end



      else

      end

    end
  end


  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  rails_admin do
    list do
      field :published
      field :avatar
      field :name
      field :short_description

    end
    show do
      field :published
      field :name
      field :short_description do 
      	label 'краткое описание'
      end
      field :content, :ck_editor do
      	label 'содержание статьи'
      end 
      field :avatar, :paperclip
    end
    edit do
      #field :published
      #field :name
      field :title
      # field :short_description do
      # 	label 'краткое описание'
      # end
      # field :content, :ck_editor do
      # 	label 'содержание статьи'
      # end

      field :translations, :globalize_tabs
      field :tag_list do
        partial 'tag_list_with_suggestions'
      end
      group :image_data do
        field :avatar, :paperclip
        field :avatar_file_name
      end

      field :release_date
      field :author
      field :static_page_data
    end
  end
end
