class TrustCompany < ActiveRecord::Base
  include PaperclipEnhancements::InstanceMethods
  extend PaperclipEnhancements::ClassMethods

  attr_accessible :published, :name, :description, :url
  has_paperclip_attached_file :avatar,
    :url          => '/assets/trust_companies/:id/:style/:basename.:extension',
    :hash_secret  => ':basename',
    :path         => ':rails_root/public/:url',
    styles: proc { |a| a.instance.resolve_avatar_styles },
    processors: [:thumbnail, :optimizer_paperclip_processor]

  def resolve_avatar_styles
    styles = {
        thumb: {
            geometry: '320x320>',
            optimizer_paperclip_processor: {  }
        }
    }

    puts "avatar_content_type: #{avatar.content_type}"

    if avatar.content_type.in?(%w(image/png image/jpg image/jpeg image/gif))
      styles[:thumb][:processors] = [:thumbnail, :optimizer_paperclip_processor]
    elsif avatar.content_type == "image/svg+xml"
      styles[:thumb][:processors] = [:optimizer_paperclip_processor]
    end



    styles
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


