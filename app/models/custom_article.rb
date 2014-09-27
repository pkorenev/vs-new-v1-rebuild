class CustomArticle < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :thumb => '150x150>', :article_item => '320x320>', home_article_item: '250x250>', article_page: '500x500>'},
                    :url  => '/assets/articles/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/articles/:id/:style/:basename.:extension'

  [:avatar].each do |paperclip_field_name|
    attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

    attr_accessor "delete_#{paperclip_field_name}".to_sym
  end

  attr_accessible :name, :slug, :short_description, :full_description, :published

  translates :name, :slug, :short_description, :full_description, :avatar_alt
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  has_paper_trail

  class Translation
    attr_accessible :locale, :published, :name, :slug, :short_description, :full_description, :avatar_alt

    # def published=(value)
    #   self[:published] = value
    # end

    before_save do
      if !self.slug || self.slug.length == 0
        self.slug = self.name.parameterize
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

  rails_admin do

    edit do
      field :published
      field :translations, :globalize_tabs
      group :avatar do
        field :avatar
        field :avatar_file_name_fallback
      end
    end
  end
end
