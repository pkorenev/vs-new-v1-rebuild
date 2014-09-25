class Route < ActiveRecord::Base
  acts_as_taggable_on :methods
  attr_accessible :methods, :method_list

  attr_accessible :name, :route_string, :route_name, :controller_action, :redirect_to_url, :position

  translates :route_string, :redirect_to_url
  accepts_nested_attributes_for :translations
  attr_accessible :translations_attributes, :translations

  class Translation
    attr_accessible :locale, :route_string, :redirect_to_url

    rails_admin do
      edit do
        field :locale, :hidden
        field :route_string
        field :redirect_to_url
      end
    end
  end

  before_save :check_fields

  def check_fields
    self.position ||= id
    if self.method_list.count == 0
      self.method_list.push 'get'
    end
  end

  after_save :reload_routes

  def reload_routes
    DynamicRouter.reload
  end

  rails_admin do
    nestable_list true

    edit do
      field :position
      field :name
      field :method_list do
        partial 'tag_list_with_suggestions'
      end
      field :route_name do
        # render do
        #   if bindings[:view]._current_user.email == 'support@voroninstudio.eu'
        #     bindings[:view].render :partial => "rails_admin/main/#{partial}", :locals => {:field => self, :form => bindings[:form] }
        #   else
        #     ''
        #   end
        # end
      end

      field :translations, :globalize_tabs do
        label "Переклад"
      end

      field :controller_action
    end
  end
end
