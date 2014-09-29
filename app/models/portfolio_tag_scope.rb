class PortfolioTagScope < ActiveRecord::Base
  belongs_to :scope_taggable, polymorphic: true
  attr_accessible :scope_taggable, :scope_taggable_id, :scope_taggable_type

  acts_as_taggable
  attr_accessible :tag_list

  rails_admin do
    edit do
      field :scope_taggable
      field :tag_list do
        partial 'tag_list_with_suggestions'
      end
    end

    nested do
      field :scope_taggable do
        hide
      end
      field :tag_list do

        partial 'tag_list_with_suggestions'
      end
    end
  end

end
