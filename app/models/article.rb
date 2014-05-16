# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
  attr_accessible :published, :name, :title, :slug, :short_description, :content, :original_published, :avatar, :delete_avatar, :tags, :tag_list, :release_date, :author

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


  before_validation :generate_slug, :generate_release_date

  def generate_slug
  	self.slug = self.name.parameterize
  end

  def generate_release_date
    self.release_date ||= self.updated_at
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
      field :published
      field :name
      field :title
      field :short_description do 
      	label 'краткое описание'
      end
      field :content, :ck_editor do
      	label 'содержание статьи'
      end
      field :tag_list do
        partial 'tag_list_with_suggestions'
      end
      field :avatar, :paperclip
      field :release_date
      field :author
      field :static_page_data
    end
  end
end
