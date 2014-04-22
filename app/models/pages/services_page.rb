class Pages::ServicesPage < ActiveRecord::Base
  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  #nested_attributes_for :static_page_data
  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes


  has_many :services
  attr_accessible :services

  accepts_nested_attributes_for :services, :allow_destroy => true
  attr_accessible :services_attributes


  #attr_accessible :content

  rails_admin do


    edit do
      field :services
      field :static_page_data
    end


  end
end
