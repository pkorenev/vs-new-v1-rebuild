class DictionaryKey < ActiveRecord::Base
  attr_accessible :key, :value, :info_description

  belongs_to :dictionary
  attr_accessible :dictionary, :dictionary_id

  translates :key, :value
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations



  class Translation
    attr_accessible :locale, :key, :value

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
      edit do
        field :locale, :hidden
        field :key
        field :value
      end
    end
  end

  rails_admin do
    edit do
      field :info_description
      field :translations, :globalize_tabs
    end
  end
end
