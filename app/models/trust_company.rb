class TrustCompany < ActiveRecord::Base
  attr_accessible :published, :name, :description, :avatar, :avatar_alt, :url
  has_attached_file :avatar,
                    :url          => '/assets/trust_companies/:id/:style/:hash.:extension',
                    :hash_secret  => ':basename',
                    :path         => ':rails_root/public/assets/trust_companies/:id/:style/:hash.:extension'

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
      field :avatar
    end
  end
end
