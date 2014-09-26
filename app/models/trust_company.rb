class TrustCompany < ActiveRecord::Base
  attr_accessible :published, :name, :description, :url
  has_attached_file :avatar,
                    :url          => '/assets/trust_companies/:id/:style/:hash.:extension',
                    :hash_secret  => ':basename',
                    :path         => ':rails_root/public/assets/trust_companies/:id/:style/:hash.:extension'

  [:avatar].each do |paperclip_field_name|
    attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

    attr_accessor "delete_#{paperclip_field_name}".to_sym
  end



  translates :name, :description, :url, :avatar_alt
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :published, :name, :description, :url, :avatar_alt

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :published
        field :name
        field :description
      end
    end
  end



  rails_admin do
    list do
      field :published
      field :name
      field :url
    end
    show do
      field :published
      field :name
      field :description
      field :url
    end
    edit do
      field :published
      field :name
      field :url
      field :description
      group :image_data do
        field :avatar, :paperclip
        field :avatar_file_name_fallback
      end
    end
  end
end
