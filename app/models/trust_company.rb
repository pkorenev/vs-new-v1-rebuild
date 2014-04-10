class TrustCompany < ActiveRecord::Base
  attr_accessible :published, :name, :description, :avatar, :url
  has_attached_file :avatar,
                    :url          => '/assets/trust_companies/:id/:style/:hash.:extension',
                    :hash_secret  => ':basename',
                    :path         => ':rails_root/public/assets/trust_companies/:id/:style/:hash.:extension'

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
