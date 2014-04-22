class Pages::HomePage < ActiveRecord::Base
  attr_accessible :greetings

  has_one :static_page_data, :as => :has_static_page_data
  attr_accessible :static_page_data

  accepts_nested_attributes_for :static_page_data, :allow_destroy => true
  attr_accessible :static_page_data_attributes



  rails_admin do


    edit do
      field :greetings, :ck_editor
      field :static_page_data
    end


  end
end