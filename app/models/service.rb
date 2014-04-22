class Service < ActiveRecord::Base
  attr_accessible :sort_id, :published, :name, :short_description, :full_description, :avatar, :avatar_file_name, :avatar_alt
  has_attached_file :avatar
  validates :sort_id, :uniqueness => true, :presence => true


  belongs_to :services_page, :class_name => 'Pages::ServicesPage'
  attr_accessible :services_page, :services_page_id

  before_validation :configure_sort_id

  def configure_sort_id
    sort_id ||= id
  end

  rails_admin do
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
     #label 'id'
    end
    field :published
    field :name
    field :short_description
    field :avatar do
      group :image_data
    end
    field :avatar_alt do
      group :image_data
    end
    field :avatar_file_name do
      group :image_data
    end
     field :services_page

   end
  end
end
