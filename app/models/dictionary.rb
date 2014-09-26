class Dictionary < ActiveRecord::Base
  attr_accessible :name, :code_name, :info_description
  has_many :dictionary_keys

  attr_accessible :dictionary_keys

  accepts_nested_attributes_for :dictionary_keys, :allow_destroy => true
  attr_accessible :dictionary_keys_attributes

  rails_admin do
    edit do
      field :name
      field :info_description
      field :dictionary_keys
      field :code_name
    end
  end




end
