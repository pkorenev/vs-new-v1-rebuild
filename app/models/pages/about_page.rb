class Pages::AboutPage < ActiveRecord::Base
  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  #nested_attributes_for :static_page_data
  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes

  attr_accessible :content
  attr_accessible :clients_intro
  attr_accessible :team_text




  rails_admin do
    field :content
    field :clients_intro
    field :team_text

    field :static_page_data
  end
end
