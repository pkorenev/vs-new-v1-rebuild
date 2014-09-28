class ActsAsTaggableOn::Tag
  translates :name
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :name

    rails_admin do
      field :locale, :hidden
      field :name
    end
  end

  rails_admin do
    list do
      field :name
      field :translations
    end

    edit do

      field :translations, :globalize_tabs
    end
  end

end