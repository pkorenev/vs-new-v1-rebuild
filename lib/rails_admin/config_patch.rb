module RailsAdmin
  module ConfigPatch
    def self.included(receiver)
      #receiver.send :include, InstanceMethods

      receiver.class_eval do
        def render_custom_fields_rows(issue)
          "It works".html_safe
        end
      end
    end

    class << self

    @navigation_static_tree = nil

    attr_accessor :navigation_static_tree

    def navigation_static_tree=(value)
      @navigation_static_tree = value
    end

    def reset
      @compact_show_view = true
      @yell_for_non_accessible_fields = true
      @authenticate = nil
      @authorize = nil
      @audit = nil
      @current_user = nil
      @default_hidden_fields = {}
      @default_hidden_fields[:base] = [:_type]
      @default_hidden_fields[:edit] = [:id, :_id, :created_at, :created_on, :deleted_at, :updated_at, :updated_on, :deleted_on]
      @default_hidden_fields[:show] = [:id, :_id, :created_at, :created_on, :deleted_at, :updated_at, :updated_on, :deleted_on]
      @default_items_per_page = 20
      @default_search_operator = 'default'
      @attr_accessible_role = nil
      @excluded_models = []
      @included_models = []
      @total_columns_width = 697
      @label_methods = [:name, :title]
      @main_app_name = proc { [Rails.application.engine_name.titleize.chomp(' Application'), 'Admin'] }
      @registry = {}
      @navigation_static_links = {}
      @navigation_static_label = nil
      RailsAdmin::Config::Actions.reset

      @navigation_static_tree = nil
    end

    end

    reset
  end
end