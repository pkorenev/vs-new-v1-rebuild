class FormConfig < ActiveRecord::Base
  acts_as_taggable_on :form_receiver
  attr_accessible :form_receiver_list
  attr_accessible :name

  rails_admin do
    edit do
      field :name
      field :form_receiver_list do
        help 'Use commas to separate e-mails'
        partial 'tag_list_with_suggestions'
      end
    end
  end
end
