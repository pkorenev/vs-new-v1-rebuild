class Service < ActiveRecord::Base
  attr_accessible :sort_id, :published, :name, :short_description, :full_description, :avatar
  has_attached_file :avatar
  validates :sort_id, :uniqueness => true, :presence => true

  rails_admin do
   list do
   field :sort_id do
     label 'id'
    end
    field :published
    field :name
    field :short_description
    field :avatar
   end
   edit do
    field :sort_id do
     label 'id'
    end
    field :published
    field :name
    field :short_description
    field :avatar
   end
  end
end
