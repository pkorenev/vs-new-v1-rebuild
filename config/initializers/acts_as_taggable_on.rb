ActsAsTaggableOn::Tag.class_eval do
#   translates :name
#   accepts_nested_attributes_for :translations
#   attr_accessible :translations_attributes, :translations
#
#   class Translation
#     attr_accessible :locale, :name
#
#     rails_admin do
#       field :locale, :hidden
#       field :name
#     end
#   end
#
   rails_admin do

     field :translations, :globalize_tabs
     field :taggings
   end
#
end