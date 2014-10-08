class DictionaryKey < ActiveRecord::Base
  attr_accessible :key, :value, :info_description

  belongs_to :dictionary
  attr_accessible :dictionary, :dictionary_id

  translates :value
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  def obj_label_method
    self.key
  end

  class Translation
    attr_accessible :locale, :value

    # def published=(value)
    #   self[:published] = value
    # end

    rails_admin do
     # object_label_method do
	#self.key
     # end
      edit do
        field :locale, :hidden
        field :value
      end
    end
  end

  rails_admin do
   object_label_method do
    :obj_label_method
   end

     edit do
      
      #field :info_description
      field :key
      field :translations, :globalize_tabs
    end
  end
end
